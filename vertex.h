//
//  vertex.h
//  test
//
//  Created by Yangdi Lyu on 1/1/19.
//  Copyright © 2019 Yangdi Lyu. All rights reserved.
//

#ifndef vertex_h
#define vertex_h
#include <vector>
#include <string>
#include <memory>
#include "edge.h"
#include "z3++.h"

class Edge;

class Vertex
{
public:
    std::string name;
    std::vector<std::shared_ptr<Edge>> inEdges;
    std::shared_ptr<Edge> outEdge;
    bool isSeq;
    
    Vertex(const std::string& nm,
           const std::vector<std::shared_ptr<Edge> >& inEdges,
           const std::shared_ptr<Edge>& outEdge, bool isSeq):
    name(nm),
    inEdges(inEdges),
    outEdge(outEdge),
    isSeq(isSeq) {}
    virtual ~Vertex() = 0;
    
    // for simulation
    virtual void evaluate() = 0;
    // set SAT expression for outEdge
    virtual void setExpr() = 0;
    
protected:
    void setExprHelper(z3::expr oe) {outEdge->e = oe;}
};

class IdtCombVertex: public Vertex
{
public:
    IdtCombVertex(const std::string& nm,
                  const std::vector<std::shared_ptr<Edge> >& inEdges,
                  const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() == 1);
    }
    ~IdtCombVertex() {};
    void evaluate();
    void setExpr();
};

class NotCombVertex: public Vertex
{
public:
    NotCombVertex(const std::string& nm,
                  const std::vector<std::shared_ptr<Edge> >& inEdges,
                  const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() == 1);
    }
    ~NotCombVertex() {};
    void evaluate();
    void setExpr();
};

class AndCombVertex: public Vertex
{
public:
    AndCombVertex(const std::string& nm,
                  const std::vector<std::shared_ptr<Edge> >& inEdges,
                  const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() >= 2);
    }
    ~AndCombVertex() {};
    void evaluate();
    void setExpr();
};

class NandCombVertex: public Vertex
{
public:
    NandCombVertex(const std::string& nm,
                   const std::vector<std::shared_ptr<Edge> >& inEdges,
                   const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() >= 2);
    }
    ~NandCombVertex(){};
    void evaluate();
    void setExpr();
};

class OrCombVertex: public Vertex
{
public:
    OrCombVertex(const std::string& nm,
                 const std::vector<std::shared_ptr<Edge> >& inEdges,
                 const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() >= 2);
    }
    ~OrCombVertex(){};
    void evaluate();
    void setExpr();
};

class NorCombVertex: public Vertex
{
public:
    NorCombVertex(const std::string& nm,
                  const std::vector<std::shared_ptr<Edge> >& inEdges,
                  const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() >= 2);
    }
    ~NorCombVertex(){};
    void evaluate();
    void setExpr();
};

class XorCombVertex: public Vertex
{
public:
    XorCombVertex(const std::string& nm,
                  const std::vector<std::shared_ptr<Edge> >& inEdges,
                  const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() >= 2);
    }
    ~XorCombVertex(){};
    void evaluate();
    void setExpr();
};

class NxorCombVertex: public Vertex
{
public:
    NxorCombVertex(const std::string& nm,
                   const std::vector<std::shared_ptr<Edge> >& inEdges,
                   const std::shared_ptr<Edge>& outEdge):
    Vertex(nm, inEdges, outEdge, false)
    {
        assert(inEdges.size() >= 2);
    }
    ~NxorCombVertex(){};
    void evaluate();
    void setExpr();
};

class SeqVertex: public Vertex
{
public:
    std::vector<std::string> inPorts;
    std::string outPort;
    // Some flip-flops contains both .Q and .QN
    std::string extraOutPort;
    std::shared_ptr<Edge> extraOutEdge;
    // In full scan mode, create dummy edge for each flipflop
    std::shared_ptr<Edge> dataEdge;
    std::shared_ptr<Edge> scanInEdge;
    SeqVertex(const std::string& nm,
              const std::vector<std::string> &inPorts,
              const std::vector<std::shared_ptr<Edge> >& inEdges,
              const std::string& outPort,
              const std::shared_ptr<Edge>& outEdge,
              const std::shared_ptr<Edge>& dataEdge,
              const std::shared_ptr<Edge>& scanInEdge,
              const std::string& extraOutPort = "",
              const std::shared_ptr<Edge>& extraOutEdge = nullptr):
    Vertex(nm, inEdges, outEdge, true), inPorts(inPorts), outPort(outPort), extraOutPort(extraOutPort), extraOutEdge(extraOutEdge), dataEdge(dataEdge), scanInEdge(scanInEdge){}
    ~SeqVertex(){};
    void evaluate();
    void setExpr();
};

#endif /* vertex_h */
