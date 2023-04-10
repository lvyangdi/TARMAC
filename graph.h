/*
 * Authors: Yangdi Lyu
 * Jan 2018
 */

#ifndef __GRAPH_H__
#define __GRAPH_H__
#include <memory>
#include <string>
#include <vector>
#include <unordered_map>
#include <set>

class Edge;
class Vertex;
class SeqVertex;
class Visitor;

class Graph
{
public:
    std::string          header;
    std::unordered_map<std::string, std::shared_ptr<Edge> >    edgArr;         /* Store all edges */
    std::vector<std::shared_ptr<Vertex> > combGates;
    std::vector<std::shared_ptr<SeqVertex> > seqGates;
    std::vector<std::shared_ptr<Edge> >   primInEdges;
    std::vector<std::shared_ptr<Edge> >   primOutEdges;
    // inEdges = primInEdges + seqGate->dataEdge
    std::vector<std::shared_ptr<Edge> >   inEdges;
    // outEdges = primOutEdges + seqGates->outEdge
    std::vector<std::shared_ptr<Edge> >   outEdges;
    std::vector<std::shared_ptr<Vertex> > topoArr;
    
    Graph() {}
    ~Graph(){}
    
    // methods for constructing graph
    inline void setName(std::string &name) {header = name;}
    inline std::shared_ptr<Edge> getEdge(const std::string& nm)
    {if (edgArr.count(nm) == 0) edgArr[nm] = std::make_shared<Edge>(nm); return edgArr[nm];}
    inline void addInEdge(const std::string& nm)
    {primInEdges.push_back(getEdge(nm));}
    inline void addOutEdge(const std::string& nm)
    {primOutEdges.push_back(getEdge(nm));}
    inline void addCombVertex(const std::string& nm, const std::shared_ptr<Vertex> &v)
    {combGates.push_back(v);}
    inline void addSeqVertex(const std::string& nm, const std::shared_ptr<SeqVertex> &v)
    {seqGates.push_back(v);}
    
    // methods for traversing graph
    void setInputOutput();
    bool topoSort();
    void setExpr();

    // constraint contains {edge name: val} that must be satisfied
    // use symbol 'X' to represent any
    std::string getSymbolInputFromConstraint(std::unordered_map<std::string, int> &constraint);
    
    // dump to or restore from old val to new val
    void dumpToOldVals();
    void restoreOldVals();
    // evaluate all nodes
    void assignInputs(const std::string &vec);
    void evaluate();
    // evaluate from specific edge
    void evaluate(std::shared_ptr<Edge> &edg);
};
#endif
