/*
 * Authors: Yangdi Lyu
 * Jan 2018
 */

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstddef>        // std::size_t
#include <sstream>
#include <iterator>
#include <algorithm>
#include <string>
#include <string.h>
#include <ctime>
#include <unordered_set>
#include "graph.h"
#include "edge.h"
#include "vertex.h"
#include "visitor.h"

void Graph::setInputOutput() {
    // Assume full scan
    inEdges = primInEdges;
    for (auto &v : seqGates) {
        inEdges.push_back(v->scanInEdge);
    }
    outEdges = primOutEdges;
    // avoid duplicate in edges
    std::unordered_set<std::shared_ptr<Edge> > poeSet(primOutEdges.begin(), primOutEdges.end());
    for (auto &v : seqGates) {
        if (poeSet.count(v->dataEdge) == 0)
            outEdges.push_back(v->dataEdge);
    }
}

// Sort vertices of g in topo order
// Construct z3 expression simultaneously (Is it too much work for one function?)
bool Graph::topoSort(){
    topoArr.clear();
    for (auto &edgElement : edgArr)
        edgElement.second->level = UINT_MAX;
    // Assign level 0 edges: primary input, flipflops, VDD/GND
    for (auto edg : inEdges) {
        edg->level = 0;
    }
    if (edgArr.count("VDD") == 1) {
        auto edg = edgArr["VDD"];
        edgArr["VDD"]->level = 0;
        edg->newVal = edg->oldVal = 1;
    }
    if (edgArr.count("GND") == 1) {
        auto edg = edgArr["GND"];
        edg->level = 0;
        edg->newVal = edg->oldVal = 0;
    }

    // assign levels to all the other nodes
    // straight-forward way, can be improved
    for (auto &v : seqGates) {
        v->outEdge->level = v->scanInEdge->level + 1;
        if (v->extraOutEdge)
            v->extraOutEdge->level = v->outEdge->level;
    }
    bool changed = true;
    while (changed) {
        changed = false;
        for (auto v : combGates) {
            if (v->outEdge->level < UINT_MAX)   continue;
            unsigned int maxInputDepth = 0;
            for (auto edg : v->inEdges) {
                maxInputDepth = (edg->level > maxInputDepth) ? edg->level : maxInputDepth;
            }
            // If all input has been visited (maxInputDepth < INT_MAX)
            if (maxInputDepth < UINT_MAX) {
                v->outEdge->level = maxInputDepth + 1;
                topoArr.push_back(v);
                changed = true;
            }
        }
    }
    for (auto edg : edgArr) {
        if (edg.second->level == UINT_MAX)
            throw "Edge " + edg.second->name + " not visited";
    }

    return (topoArr.size() == combGates.size());
}

void Graph::setExpr() {
    // Assign level 0 edges: primary input, flipflops, VDD/GND
    for (auto edg : inEdges) {
        edg->setBVConst();
    }
    if (edgArr.count("VDD") == 1) {
        edgArr["VDD"]->setBVVal(1);
    }
    if (edgArr.count("GND") == 1) {
        edgArr["GND"]->setBVVal(0);
    }
    
    for (auto &v : seqGates) {
        v->setExpr();
    }
    
    for (auto &v : topoArr) {
        v->setExpr();
    }
}

void Graph::assignInputs(const std::string &vec)
{
    assert(inEdges.size() == vec.size());
    auto edgIter = inEdges.begin();
    for (auto vecIter = vec.begin(); (edgIter != inEdges.end()) && (vecIter != vec.end()); ++edgIter, ++vecIter) {
        assert((*vecIter == '1') || (*vecIter == '0'));
        (*edgIter)->newVal = (*vecIter == '1');
    }
}

void Graph::dumpToOldVals(){
    for (auto &edg: edgArr)
        edg.second->oldVal = edg.second->newVal;
}

void Graph::restoreOldVals(){
    for (auto &edg: edgArr)
        edg.second->newVal = edg.second->oldVal;
}

void Graph::evaluate() {
    std::for_each(inEdges.begin(), inEdges.end(), [](std::shared_ptr<Edge> &edg){edg->delay = 0;});
    for (auto &v : seqGates)
        v->evaluate();
    for (auto &v : topoArr) {
        v->evaluate();
        unsigned int maxDelay = 0;
        for (auto &edg : v->inEdges) maxDelay = std::max(edg->delay, maxDelay);
        auto &edg = v->outEdge;
        edg->delay = (edg->newVal != edg->oldVal) ? (maxDelay + 1) : 0;
    }
}

void Graph::evaluate(std::shared_ptr<Edge> &edg) {
    auto it = topoArr.begin();
    for (;it != topoArr.end(); ++it)
        if (std::find(edg->toNodes.begin(), edg->toNodes.end(), *it) != edg->toNodes.end())  break;
    if (it == topoArr.end())
        throw "Could not use primary output as payload";
    while (it != topoArr.end()) {
        (*it)->evaluate();
        unsigned int maxDelay = 0;
        for (auto &edg : (*it)->inEdges) maxDelay = std::max(edg->delay, maxDelay);
        auto &edg = (*it)->outEdge;
        edg->delay = (edg->newVal != edg->oldVal) ? (maxDelay + 1) : 0;
        it++;
    }
}

std::string Graph::getSymbolInputFromConstraint(std::unordered_map<std::string, int> &constraint) {
    std::string vec;
    for (auto &edg: inEdges) {
        std::unordered_map<std::string, int>::iterator it = constraint.find(edg->name);
        vec += (it == constraint.end()) ? 'X' : ((it->second == 0) ? '0' : '1');
    }
    return vec;
}
