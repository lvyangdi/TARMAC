//
//  visitor.h
//  test
//
//  Created by Yangdi Lyu on 1/1/19.
//  Copyright © 2019 Yangdi Lyu. All rights reserved.
//

#ifndef __VISITOR_H__
#define __VISITOR_H__
#include <memory>
#include <string>
#include <unordered_set>
#include <string>
#include <unordered_map>
#include <vector>
#include <map>

class Graph;
class Edge;

class Visitor
{
public:
    std::vector<std::shared_ptr<Edge>> lowprobEdges;
    std::vector<std::vector<std::shared_ptr<Edge>>> triggerInstances;
    std::vector<std::shared_ptr<Edge>> payloadInstances;
    
    Visitor(const std::shared_ptr<Graph> &g, std::string vecFilename, float TRIGTHRESH): g(g), TRIGTHRESH(TRIGTHRESH), vecFilename(vecFilename) {}
    
    /*
     * simulate one vector
     */
    void simOneVector(const std::string &vec);
    
    /*
     * generate stat from a number of test vectors
     * vecs: a number of test vectors, normally random vectors
     * TRIGTHRESH: rareness definition rare edge
     */
    void generateStat(const std::vector<std::string>& vecs);
    void generateStat(const std::vector<std::string>& vecs, size_t numLowProbEdges);
    /*
     * for skipping random simulation
     */
    void dumpLowNodes(std::string nodefilename);
    void readLowNodes(std::string nodefilename);
    
    /*
     * generate Trojan for a benchmark
     * filename: the output file name for Trojan
     * numTriggers: number of triggers per Trojan
     * numTrojan: number of generated Trojan
     * asset: if asset protection is true, only one payload is allowed
     */
    void generateTrojan(std::string filename, unsigned int numTriggers, unsigned int numTrojans, bool asset = false);
    
    /*
     * Simulate and test the number of triggerred condition
     * vecs: a number of test vectors
     * return the number of covered trigger conditions
     */
    int triggerSim(const std::vector<std::string> &vecs);
    
    /*
     * test if a trigger is activated
     * triggers: trigger condition contains a list of edges
     * the trigger condition is tested on new values of graph
     * return true if activated
     */
    bool isTrigActivate(std::vector<std::shared_ptr<Edge>> &triggers);
    
    /*
     * generate test
     * vecs: keep generated test vectors
     */
    void TARMAC(std::vector<std::string> &vecs, unsigned int numVectors);
    void MERO(std::vector<std::string> &vecs, std::vector<std::string> &randvecs, const unsigned int Ndetect);

private:
    std::shared_ptr<Graph> g;
    const int SEQSTATES = 1;
    float TRIGTHRESH;
    std::string vecFilename;
    
    /*
     * neighbor of each vertex (rare signal)
     */
    std::vector<std::vector<size_t>> ngbMatrix;
    
    /*
     * test if we insert a Trojan from triggerSet and payload will give loop
     * used in generateTrojan
     */
    bool loopExist(const std::unordered_set<std::shared_ptr<Edge>>& triggerSet, const std::shared_ptr<Edge>& payload);
    
    /*
     * read Trojans from file
     * trojanfilename: contains all trojans, one line per trojan
     * Trojan format: Trigger1 Trigger2 ... TriggerN Payload
     */
    void readTrojansFromFile(const std::string& trojanfilename);
    
    /*
     * test if a payload is propagated
     * Assume we already tested triggers are activated
     */
    bool payloadPropagated(std::shared_ptr<Edge> &payload);
    
    /*
     * count the number of rare singals being satisified its rare value
     * trigList: should be the same size as rare signals
     * increment the corresponding position if rare signal is activated
     */
    unsigned int countHits(std::vector<unsigned int> &trigList);
    
    /*
     * generate random test vector from a symbol vector
     * origvec: symbol vector contains 'X'
     */
    std::string getRandFromSym(const std::string &origvec);

    /*
     * helper function for MERO
     */
    void sortRandomTestset(std::vector<std::string> &randvecs, std::multimap<int, std::string>& testset);
};

#endif
