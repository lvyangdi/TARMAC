//
//  visitor.cpp
//  test
//
//  Created by Yangdi Lyu on 1/1/19.
//  Copyright © 2019 Yangdi Lyu. All rights reserved.
//
#include <iostream>
#include <fstream>
#include <sstream>
#include <algorithm>
#include <sys/stat.h>
#include <numeric>
#include <chrono>
#include <random>
#include <stack>
#include <vector>
#include <queue>
#include <iterator>
#include <map>
#include <unordered_set>
#include "visitor.h"
#include "graph.h"
#include "vertex.h"
#include "interpreter.h"
#include "edge.h"
#include "z3++.h"

void Visitor::simOneVector(const std::string &vec) {
    g->assignInputs(vec);
    g->evaluate();
}

void Visitor::generateStat(const std::vector<std::string>& vecs) {
    std::unordered_map<std::string, int> countOne;
    for (const std::string& vec: vecs) {
        // apply the test pattern to PI's
        simOneVector(vec);
        for(auto& edgElement: g->edgArr)
            countOne[edgElement.first] += (edgElement.second->newVal) ? 1 : 0;
    }
    
    // Simulation done, computing the probability of each value
    const size_t vecSize = vecs.size();
    double highProb;
    for(auto &edgElement: g->edgArr) {
        std::shared_ptr<Edge> q = edgElement.second;
        highProb = ((double)countOne[edgElement.first])/vecSize;
        q->lowProb = (highProb < 0.5) ? highProb : (1 - highProb);
        q->lowProbVal = highProb < 0.5;
        if ((q->lowProb <= TRIGTHRESH) && (q->solve(q->lowProbVal ? 1 : 0))){
            lowprobEdges.push_back(q);
        }
    }
}

void Visitor::generateStat(const std::vector<std::string>& vecs, size_t numLowProbEdges) {
    std::unordered_map<std::string, int> countOne;
    std::multimap<double, std::shared_ptr<Edge>> edgeMap;
    for (const std::string& vec: vecs) {
        // apply the test pattern to PI's
        simOneVector(vec);
        for(auto& edgElement: g->edgArr)
            countOne[edgElement.first] += (edgElement.second->newVal) ? 1 : 0;
    }
    
    // Simulation done, computing the probability of each value
    const size_t vecSize = vecs.size();
    double highProb;
    for(auto &edgElement: g->edgArr) {
        std::shared_ptr<Edge> q = edgElement.second;
        highProb = ((double)countOne[edgElement.first])/vecSize;
        q->lowProb = (highProb < 0.5) ? highProb : (1 - highProb);
        q->lowProbVal = highProb < 0.5;
        edgeMap.insert(std::pair<double, std::shared_ptr<Edge>>(q->lowProb, q));
    }
    
    auto it = edgeMap.begin();
    for (; (lowprobEdges.size() < numLowProbEdges) && (it != edgeMap.end()); ++it) {
        auto edg = it->second;
        if (edg->solve(edg->lowProbVal ? 1 : 0))
            lowprobEdges.push_back(edg);
    }
    
    std::cout << "low prob edge with probability less than " << it->first << std::endl;
}

void Visitor::dumpLowNodes(std::string nodefilename)
{
    std::ofstream fnodes(nodefilename.c_str());
    for(auto &edg : lowprobEdges) {
        fnodes << edg->name << "\t" << edg->lowProbVal << "\t" << edg->lowProb << std::endl;
    }
    fnodes.close();
}

void Visitor::readLowNodes(std::string nodefilename)
{
    std::ifstream fnodes(nodefilename.c_str());
    assert(fnodes.is_open());
    while(fnodes.good()) {
        std::string name;
        fnodes >> name;
        if (name.length() == 0) break;
        if (g->edgArr.count(name) == 0)
            std::cout << "warning: edge " << name << " does not exist\n";
        else {
            auto edg = g->edgArr[name];
            int lowProbVal;
            fnodes >> lowProbVal;
            assert(lowProbVal == 0 || lowProbVal == 1);
            edg->lowProbVal = lowProbVal == 1;
            fnodes >> edg->lowProb;
            lowprobEdges.push_back(edg);
        }
    }
    fnodes.close();
}

void Visitor::generateTrojan(std::string filename, unsigned int numTriggers, unsigned int numTrojans, bool asset)
{
    struct stat buffer;
    if (stat(filename.c_str(), &buffer) == 0) {
        std::cout << "Reading trojan from file " << filename << std::endl;
        readTrojansFromFile(filename);
        return;
    }
    std::cout << "Generate trojan file to " << filename << std::endl;
    triggerInstances.clear();
    payloadInstances.clear();
    std::ofstream trojanfile(filename.c_str());
    
    // get valid payloads that is not primary input nor primary output
    std::vector<std::shared_ptr<Edge>> payloads;
    if (!asset) {
        std::set<std::shared_ptr<Edge>> primOut(g->outEdges.begin(), g->outEdges.end());
        for (auto& v : g->topoArr) {
            if (primOut.count(v->outEdge) == 0)
                payloads.push_back(v->outEdge);
        }
    }
    // if asset protection, protect only one payload
    else {
        std::cout << "asset protection: ";
        payloads.push_back(g->seqGates[rand() % g->seqGates.size()]->outEdge);
        std::cout << payloads[0]->name << std::endl;
    }
    
    // randomly generate numTrojans Trojans
    while (payloadInstances.size() < numTrojans) {
        // randomly select triggers, using set to avoid duplication
        std::unordered_map<std::string, int> assign;
        std::unordered_set<std::shared_ptr<Edge>> triggersSet;
        std::vector<std::shared_ptr<Edge>> candidate = lowprobEdges;
        std::shared_ptr<Edge> last = nullptr;
        while (triggersSet.size() < numTriggers) {
            size_t candsize = candidate.size();
            if (candsize == 0)  break;
            size_t idx = rand() % candsize;
            last = candidate[idx];
            candidate.erase(candidate.begin() + idx);
            triggersSet.insert(last);
            if (!Edge::satisfiable(triggersSet, assign))
                triggersSet.erase(last);
        }
        assert(Edge::satisfiable(triggersSet, assign));
        if (triggersSet.size() == numTriggers) {
            // find potential payload, try a few times
            bool valid = false;
            std::shared_ptr<Edge> selectedPayload;
            for (int trial = 0; (!valid) && (trial < 20); ++trial) {
                selectedPayload = payloads[rand() % payloads.size()];
                valid = !loopExist(triggersSet, selectedPayload);
            }
        
            if (!valid) continue;
            // dump valid Trojans to file
            std::vector<std::shared_ptr<Edge>> onetrigger;
            for (auto &edg : triggersSet) {
                onetrigger.push_back(edg);
                trojanfile << edg->name << " ";
            }
            triggerInstances.push_back(onetrigger);
            payloadInstances.push_back(selectedPayload);
            trojanfile << selectedPayload->name << "\n";
            
#ifdef DEBUG
            // validate
            std::string vec = getRandFromSym(g->getSymbolInputFromConstraint(assign));
            simOneVector(vec);
            assert(isTrigActivate(onetrigger));
#endif
        }
    }
    
    trojanfile.close();
    std::cout << "Finished generating trojan file in " << filename << std::endl;
}

bool Visitor::loopExist(const std::unordered_set<std::shared_ptr<Edge>>& triggerSet, const std::shared_ptr<Edge>& payload)
{
    std::unordered_set<std::string> visited;
    std::stack<std::shared_ptr<Edge>> toVisit;
    toVisit.push(payload);
    while (!toVisit.empty()) {
        std::shared_ptr<Edge> curr = toVisit.top();
        if (triggerSet.count(curr) > 0) return true;
        toVisit.pop();
        visited.insert(curr->name);
        if (curr->toNodes.empty()) continue;
        for (auto &v : curr->toNodes) {
            if (!v->isSeq &&
                (visited.count(v->outEdge->name) == 0))
                toVisit.push(v->outEdge);
        }
    }
    return false;
}

// Simulate with test vectors from filename
// triggers and payload already read from file
int Visitor::triggerSim(const std::vector<std::string> &vecs) {
    std::vector<int> trigcoveredList(payloadInstances.size(), 0);
    std::vector<bool> trojcoveredList(payloadInstances.size(), false);
    int trigcoveredCnt = 0;
    int trojcoveredCnt = 0;
    
    // Initialize the graph
    const size_t inputSize = g->inEdges.size();
    std::string onevec(inputSize, '0');
    simOneVector(onevec);
#ifdef DEBUG
    size_t ntriggers = triggerInstances[0].size();
    std::ofstream fvectordebug("Debug/" + g->header + "_" + std::to_string(ntriggers) + "_" + std::to_string(TRIGTHRESH) + ".debug");
    std::ofstream ftriggerlist("Debug/" + g->header + "_" + std::to_string(ntriggers) + "_" + std::to_string(TRIGTHRESH) + ".triggerlist");
    fvectordebug << "#vec\trare hits\taccumulate detected Trojan\n";
    unsigned int idx = 0;
    std::vector<unsigned int> trigList(lowprobEdges.size(), 0);
#endif
    for (const std::string& vec: vecs) {
        // apply the test pattern to PI's
        simOneVector(vec);
        
        // Check for trigger conditions
        for (size_t i = 0; i < payloadInstances.size(); ++i){
            if (trojcoveredList[i])    continue;
            bool covered = true;
            for (auto &edg : triggerInstances[i]) {
                if (edg->newVal != edg->lowProbVal){
                    covered = false;
                    break;
                }
            }
            if (covered) {
                if (trigcoveredList[i] < SEQSTATES) {
                    ++trigcoveredList[i];
                    trigcoveredCnt += (trigcoveredList[i] == SEQSTATES) ? 1 : 0;
                }
                
                if ((trigcoveredList[i] == SEQSTATES) && payloadPropagated(payloadInstances[i])) {
                    trojcoveredList[i] = true;
                }
            }
        }
        
#ifdef DEBUG
        // Dump index, rare signal hits, cumulative trigger count per vector
        fvectordebug << ++idx << "\t" << countHits(trigList) << "\t" << trigcoveredCnt << std::endl;
#endif
    }
    trojcoveredCnt = std::count_if(trojcoveredList.begin(), trojcoveredList.end(), [](const bool &t) {return t;});
    std::cout << "trigger : " << trigcoveredCnt << " troj : " << trojcoveredCnt << std::endl;
#ifdef DEBUG
    std::copy(trigList.begin(), trigList.end(), std::ostream_iterator<unsigned int>(ftriggerlist, "\n"));
    fvectordebug.close();
    ftriggerlist.close();
#endif
    return trigcoveredCnt;
}

bool Visitor::payloadPropagated(std::shared_ptr<Edge>& payload)
{
    g->dumpToOldVals();
    payload->newVal = !payload->newVal;
    g->evaluate(payload);
    bool found = std::any_of(g->outEdges.begin(), g->outEdges.end(), [](std::shared_ptr<Edge> &edg) {return (edg->oldVal != edg->newVal);});
    // restore old values to test next Trojan
    g->restoreOldVals();
    return found;
}

// Read trojans from file
// Trojans are defined as [Trigger1, Trigger2, ..., TriggerN, Payload] in trojanfile
void Visitor::readTrojansFromFile(const std::string &trojanfilename){
    triggerInstances.clear();
    payloadInstances.clear();
    std::ifstream ftroj(trojanfilename.c_str());
    if (!ftroj.is_open()) {
        throw "Trojan file " + trojanfilename + " not present";
    }
    std::string line;
    while (getline(ftroj, line)) {
        std::istringstream iss(line);
        std::vector<std::shared_ptr<Edge>> onetrigger;
        std::string edgname;
        while (iss.good()) {
            iss >> edgname;
            onetrigger.push_back(g->getEdge(edgname));
        }
        payloadInstances.push_back(onetrigger.back());
        onetrigger.pop_back();
        triggerInstances.push_back(onetrigger);
    }
    ftroj.close();
}

bool Visitor::isTrigActivate(std::vector<std::shared_ptr<Edge>> &triggers) {
    for (auto &edg : triggers)
        if (edg->newVal != edg->lowProbVal) {
            return false;
        }
    return true;
}

void Visitor::TARMAC(std::vector<std::string> &vecs, unsigned int numVectors)
{
    const size_t lowSize = lowprobEdges.size();
    std::cout << "Generating TARMAC vectors in file " << vecFilename << std::endl;
    std::ofstream fvec(vecFilename.c_str());
    
    // initialize ngbMatrix
    std::vector<size_t> line;
    for (size_t i = 0; i < lowSize; ++i)
        line.push_back(i);
    ngbMatrix = std::vector<std::vector<size_t>>(lowSize, line);
    for (size_t i = 0; i < lowSize; ++i)
        ngbMatrix[i].erase(ngbMatrix[i].begin() + i);
    
    z3::context &c = Edge::getContext();
    z3::solver s(c);
    for (size_t i = 0; i < numVectors; ++i) {
        s.reset();
        std::vector<size_t> lowEdgeComb;
        int selectIdx = rand() % lowSize;
        lowEdgeComb.push_back(selectIdx);
        s.add(lowprobEdges[selectIdx]->e == lowprobEdges[selectIdx]->lowProbVal);
        std::vector<size_t> P = ngbMatrix[selectIdx];
        while (!P.empty()) {
            selectIdx = rand() % P.size();
            size_t select = P[selectIdx];
            s.push();
            s.add(lowprobEdges[select]->e == lowprobEdges[select]->lowProbVal);
            z3::check_result result = s.check();
            if (result == z3::sat) {
                lowEdgeComb.push_back(select);
                auto it = std::remove_if(P.begin(), P.end(), [this, &select](size_t &p){return !std::binary_search(ngbMatrix[select].begin(), ngbMatrix[select].end(), p);});
                P.erase(it, P.end());
            } else if (result == z3::unsat) {
                P.erase(P.begin() + selectIdx);
                s.pop();
                if (lowEdgeComb.size() == 1){
                    size_t prev = lowEdgeComb[0];
                    auto it = std::lower_bound(ngbMatrix[prev].begin(), ngbMatrix[prev].end(), select);
#ifdef DEBUG
                    assert(*it == select);
#endif
                    ngbMatrix[prev].erase(it);
                    it = std::lower_bound(ngbMatrix[select].begin(), ngbMatrix[select].end(), prev);
#ifdef DEBUG
                    assert(*it == prev);
#endif
                    ngbMatrix[select].erase(it);
                }
            } else {
                std::cerr << "Z3 unknown\n";
            }
        }
        assert(s.check() == z3::sat);
        std::unordered_map<std::string, int> assign;
        z3::model m = s.get_model();
        for (unsigned i = 0; i < m.size(); ++i) {
            z3::func_decl v = m[i];
            assign[v.name().str()] = m.get_const_interp(v).get_numeral_int();
        }
        std::string vec = getRandFromSym(g->getSymbolInputFromConstraint(assign));
        vecs.push_back(vec);
        fvec << vec << std::endl;
    }
    
    std::cout << "Finish generating TARMAC vectors in file " << vecFilename << std::endl;
    fvec.close();
}

std::string Visitor::getRandFromSym(const std::string &origvec)
{
    int twopower = 16;
    int maxRand = (1 << twopower) - 1;
    // use better pseudo-random generator than rand() % 2
    std::mt19937 e(std::random_device{}());
    std::uniform_int_distribution<int> uniform_dist(0, maxRand);
    
    int count = 0;
    int r = uniform_dist(e);
    std::string vec = origvec;
    for (auto it = vec.begin(); it != vec.end(); ++it) {
        if ((*it) != 'X')   continue;
        *it = (r & 1) ? '1' : '0';
        r >>= 1;
        if (++count == twopower) {
            count = 0;
            r = uniform_dist(e);
        }
    }
    return vec;
}

unsigned int Visitor::countHits(std::vector<unsigned int> &trigList)
{
    unsigned int hits = 0;
    for (size_t i = 0; i < lowprobEdges.size(); ++i)
        if (lowprobEdges[i]->newVal == lowprobEdges[i]->lowProbVal) {
            ++hits;
            ++trigList[i];
        }
    return hits;
}

void Visitor::MERO(std::vector<std::string> &vecs, std::vector<std::string> &randvecs, const unsigned int Ndetect)
{
    std::cout << "Generating MERO vectors in file " << vecFilename << std::endl;
    std::ofstream fvec(vecFilename.c_str());
    // Use multimap to sort random tests
    std::multimap<int, std::string> testset;
    sortRandomTestset(randvecs, testset);

    std::cout << "INFO: Generating N-Detect vectors ...\n";
    std::vector<unsigned int> trigList(lowprobEdges.size(), 0);

    for (auto it = testset.rbegin(); it != testset.rend(); it++) {
        int besthits = 0, nhits = 0;
        std::string vec1 = it->second;
        simOneVector(vec1);
        for (size_t i = 0; i < lowprobEdges.size(); ++i)
            if ((lowprobEdges[i]->newVal == lowprobEdges[i]->lowProbVal) && (trigList[i] < Ndetect)) {
                ++besthits;
            }
        // Flip one bit of test vectors to increase coverage
        // Multiple rounds and flipping multiple bits could increase coverage
        for (size_t i = 0; i < vec1.length(); i++) {
            vec1[i] = (vec1[i] == '0') ? '1' : '0';
            simOneVector(vec1);

            nhits = 0;
            for (size_t i = 0; i < lowprobEdges.size(); ++i)
                if ((lowprobEdges[i]->newVal == lowprobEdges[i]->lowProbVal) && (trigList[i] < Ndetect)) {
                    ++nhits;
                }
            if (nhits <= besthits)
                vec1[i] = (vec1[i] == '0') ? '1' : '0';
            else
                besthits = nhits;
        }

        // decide whether to keep current best vector
        simOneVector(vec1);
        nhits = 0;
        for (size_t i = 0; i < lowprobEdges.size(); ++i)
            if ((lowprobEdges[i]->newVal == lowprobEdges[i]->lowProbVal) && (trigList[i] < Ndetect)) {
                ++nhits;
                ++trigList[i];
            }
        if (nhits) {
            vecs.push_back(vec1);
            fvec << vec1 << std::endl;
        }
    }
    std::cout << "Finish generating MERO vectors in file " << vecFilename << std::endl;
    fvec.close();
}

// Simulate test vectors from filename
// Sort based on the number of hits in rare nodes
void Visitor::sortRandomTestset(std::vector<std::string> &randvecs, std::multimap<int, std::string>& testset) {   
    for (auto &vec : randvecs) {
        int nhits = 0;
        simOneVector(vec);
        for (auto &edg : lowprobEdges)
            nhits += (edg->newVal == edg->lowProbVal) ? 1 : 0;

        if (nhits > 0)
            testset.insert(std::make_pair(nhits, vec));
    }
}
