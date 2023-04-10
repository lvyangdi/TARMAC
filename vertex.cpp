//
//  vertex.cpp
//  test
//
//  Created by Yangdi Lyu on 1/1/19.
//  Copyright © 2019 Yangdi Lyu. All rights reserved.
//

#include <algorithm>
#include "vertex.h"
#include "edge.h"

Vertex::~Vertex() {};

void IdtCombVertex::evaluate()
{
    outEdge->newVal = inEdges[0]->newVal;
}

void IdtCombVertex::setExpr()
{
    Vertex::setExprHelper(inEdges[0]->getExpr());
}

void NotCombVertex::evaluate()
{
    outEdge->newVal = !inEdges[0]->newVal;
}

void NotCombVertex::setExpr()
{
    Vertex::setExprHelper(~inEdges[0]->getExpr());
}

void AndCombVertex::evaluate()
{
    outEdge->newVal = true;
    std::for_each(inEdges.begin(), inEdges.end(), [this](const std::shared_ptr<Edge> &edg) {if (edg->newVal == false) outEdge->newVal = false;});
}

void AndCombVertex::setExpr()
{
    z3::expr e = inEdges[0]->getExpr();
    for (auto it = inEdges.begin() + 1; it != inEdges.end(); ++it)
        e = e & (*it)->getExpr();
    Vertex::setExprHelper(e);
}

void NandCombVertex::evaluate()
{
    outEdge->newVal = true;
    std::for_each(inEdges.begin(), inEdges.end(), [this](const std::shared_ptr<Edge> &edg) {if (edg->newVal == false) outEdge->newVal = false;});
    outEdge->newVal = !outEdge->newVal;
}

void NandCombVertex::setExpr()
{
    z3::expr e = inEdges[0]->getExpr();
    for (auto it = inEdges.begin() + 1; it != inEdges.end(); ++it)
        e = e & (*it)->getExpr();
    Vertex::setExprHelper(~e);
}

void OrCombVertex::evaluate()
{
    outEdge->newVal = false;
    std::for_each(inEdges.begin(), inEdges.end(), [this](const std::shared_ptr<Edge> &edg) {if (edg->newVal == true) outEdge->newVal = true;});
}

void OrCombVertex::setExpr()
{
    z3::expr e = inEdges[0]->getExpr();
    for (auto it = inEdges.begin() + 1; it != inEdges.end(); ++it)
        e = e | (*it)->getExpr();
    Vertex::setExprHelper(e);
}

void NorCombVertex::evaluate()
{
    outEdge->newVal = false;
    std::for_each(inEdges.begin(), inEdges.end(), [this](const std::shared_ptr<Edge> &edg) {if (edg->newVal == true) outEdge->newVal = true;});
    outEdge->newVal = !outEdge->newVal;
}

void NorCombVertex::setExpr()
{
    z3::expr e = inEdges[0]->getExpr();
    for (auto it = inEdges.begin() + 1; it != inEdges.end(); ++it)
        e = e | (*it)->getExpr();
    Vertex::setExprHelper(~e);
}

void XorCombVertex::evaluate()
{
    long cnt = std::count_if(inEdges.begin(), inEdges.end(), [](const std::shared_ptr<Edge> &edg) {return edg->newVal;});
    outEdge->newVal = (cnt % 2 == 1);
}

void XorCombVertex::setExpr()
{
    z3::expr e = inEdges[0]->getExpr();
    for (auto it = inEdges.begin() + 1; it != inEdges.end(); ++it)
        e = e ^ (*it)->getExpr();
    Vertex::setExprHelper(e);
}

void NxorCombVertex::evaluate()
{
    long cnt = std::count_if(inEdges.begin(), inEdges.end(), [](const std::shared_ptr<Edge> &edg) {return edg->newVal;});
    outEdge->newVal = (cnt % 2 == 0);
}

void NxorCombVertex::setExpr()
{
    z3::expr e = inEdges[0]->getExpr();
    for (auto it = inEdges.begin() + 1; it != inEdges.end(); ++it)
        e = e ^ (*it)->getExpr();
    Vertex::setExprHelper(~e);
}

void SeqVertex::evaluate()
{
    outEdge->newVal = (outPort.substr(0, 3).compare(".QN")) ? scanInEdge->newVal : !scanInEdge->newVal;
    if (extraOutEdge)
        extraOutEdge->newVal = (extraOutPort.substr(0, 3).compare(".QN")) ? scanInEdge->newVal : !scanInEdge->newVal;
}

void SeqVertex::setExpr()
{
    outEdge->e = (outPort.substr(0, 3).compare(".QN")) ? scanInEdge->e : ~scanInEdge->e;
    if (extraOutEdge)
        extraOutEdge->e = (extraOutPort.substr(0, 3).compare(".QN")) ? scanInEdge->e : ~scanInEdge->e;
}
