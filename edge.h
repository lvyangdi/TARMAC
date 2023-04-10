//
//  Created by Yangdi Lyu on 1/1/19.
//  Copyright © 2019 Yangdi Lyu. All rights reserved.
//

#ifndef edge_h
#define edge_h
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <memory>
#include "z3++.h"

class Graph;
class Vertex;

class Edge
{
    friend class Vertex;
    friend class SeqVertex;
    friend class Graph;
public:
    std::string name;
    // true for high, false for low
    bool oldVal;
    bool newVal;
    bool lowProbVal;
    // probability of low val
    double lowProb;
    unsigned int level;
    unsigned int delay;
    std::shared_ptr<Vertex> fromNode;
    std::vector<std::shared_ptr<Vertex> > toNodes;
    z3::expr e;
    
    Edge(std::string nm):
    name(nm), oldVal(false), newVal(false), lowProbVal(false), lowProb(1.0), level(UINT_MAX), delay(0),
    e(c){}
    
    // methods for constructing edges
    inline void setFromNode(const std::shared_ptr<Vertex> fn) {fromNode = fn;}
    inline void addToNodes(const std::shared_ptr<Vertex> fn) {toNodes.push_back(fn);}
    
    // methods for SAT solver
    static inline z3::context& getContext() {return c;}
    inline const z3::expr& getExpr() {return e;}

    /*
     * check if e can be val
     */
    bool solve(int val);
    /*
     * check and return contraints in assign
     */
    bool solve(int val, std::unordered_map<std::string, int> &assign);

    /*
     * check if a rare edges can be satisfiable (with their lowProbVal)
     */
    static bool satisfiable(std::unordered_set<std::shared_ptr<Edge> > &triggers, std::unordered_map<std::string, int> &assign);
    
private:
    static z3::context c;   // common for all edges
    // The number of bits for each Edge, normally one bit
    static unsigned int bv_size;
    
    /*
     * For inputs, set as free variable
     */
    void setBVConst();
    /*
     * For GND and VDD, set as value
     */
    void setBVVal(unsigned int val);
};

#endif /* edge_h */
