//
//  interpreter.h
//  pathdelay
//
//  Created by Yangdi Lyu on 12/31/18.
//  Copyright © 2018 Yangdi Lyu. All rights reserved.
//

#ifndef interpreter_h
#define interpreter_h

#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include "graph.h"

class Interpreter
{
public:
    Interpreter(const std::string& sourceFileName):
        sourceFileName(sourceFileName),
        g(std::make_shared<Graph>()) {}
    
    std::shared_ptr<Graph> createGraph();

private:
    const static std::unordered_map<std::string, std::string> TYPESMAP;
    const static std::unordered_set<std::string> INPORTSNAME;
    const static std::unordered_set<std::string> OUTPORTSNAME;
    std::string sourceFileName;
    std::shared_ptr<Graph> g;
    // file parsing
    void preprocess(std::vector<std::vector<std::string> > &lines);
    void parse(std::vector<std::string> &oneline);
    
    /*
     * comb vertex factory
     * supported vertex types are defined in MKFUN
     */
    std::shared_ptr<Vertex> makeCombVertex(const std::string& type, const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    typedef std::shared_ptr<Vertex> (*MKVERTEXFUN) (const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    const static std::unordered_map<std::string, MKVERTEXFUN> MKFUN;

    /*
     * seq vertex factory
     * a scan in edge is created for each seq vertex with the same name as vertex
     * only two outedge is supported, one for .Q, one for .QN
     */
    std::shared_ptr<SeqVertex> makeSeqVertex(const std::string& name, const std::vector<std::string> &inPorts, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::vector<std::string>& outPort, const std::vector<std::shared_ptr<Edge>>& outEdge);
    
    // helper to create comb vertex
    static std::shared_ptr<Vertex> makeIdtCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    static std::shared_ptr<Vertex> makeNotCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    static std::shared_ptr<Vertex> makeAndCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    static std::shared_ptr<Vertex> makeNandCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    static std::shared_ptr<Vertex> makeOrCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    static std::shared_ptr<Vertex> makeNorCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    static std::shared_ptr<Vertex> makeXorCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
    static std::shared_ptr<Vertex> makeNxorCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge);
};

#endif /* interpreter_h */
