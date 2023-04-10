//
//  interpreter.cpp
//  pathdelay
//
//  Created by Yangdi Lyu on 12/31/18.
//  Copyright © 2018 Yangdi Lyu. All rights reserved.
//

#include <algorithm>
#include <iostream>
#include <iterator>
#include <sstream>
#include <fstream>
#include <memory>
#include <regex>
#include "vertex.h"
#include "graph.h"
#include "edge.h"
#include "interpreter.h"

// make sure no key is a prefix of another key
const std::unordered_map<std::string, std::string> Interpreter::TYPESMAP = {
    {"dff", "dff"}, {"nor", "nor"} , {"nnd", "nand"}, {"and", "and"},
    {"xor", "xor"}, {"xnr", "nxor"}, {"ib1", "not"}, {"nb1", "idt"},
    {"or", "or"}, {"hi", "not"}, {"i1", "not"}, {"assign", "idt"}};

const std::unordered_set<std::string> Interpreter::INPORTSNAME = {".IN", ".AIN", ".BIN", ".CIN", ".DIN", ".SIN", ".CLK", "CLK", ".CLR", ".SET", ".EB"};

// make sure .Q is after .QN so that it can find the correct one
const std::unordered_set<std::string> Interpreter::OUTPORTSNAME = {".QN", ".OUT", ".Q"};

void Interpreter::preprocess(std::vector<std::vector<std::string> > &lines)
{
    std::ifstream sourceFile(sourceFileName.c_str());
    assert(sourceFile.is_open());
    std::string line;
    std::string inputs;
    // Read line by line and remove comments
    while (std::getline(sourceFile, line)) {
        size_t pos = line.find("//");
        if (pos != std::string::npos)
            line.erase(pos);
        inputs += line;
    }
    
    // replace GND and VDD
    size_t pos = inputs.find("1'b0");
    while (pos != std::string::npos) {
        inputs.replace(pos, 4, "GND ");
        pos = inputs.find("1'b0");
    }
    
    pos = inputs.find("1'b1");
    while (pos != std::string::npos) {
        inputs.replace(pos, 4, "VDD ");
        pos = inputs.find("1'b1");
    }
    
    // replace '=,\t\n()' with blank space
    std::replace_if(inputs.begin(),
                    inputs.end(),
                    [](const char& c)
                    {return std::string("=,\t\r\n()").find(c) != std::string::npos;},
                    ' ');
    
    // TODO: only one module is supported
    size_t first = inputs.find("endmodule");
    if ((first == std::string::npos) || (inputs.find("endmodule", first + 1) != std::string::npos))
        throw "One and only one module is supported in design";
    
    // parse each part, separated by ';'
    char delimiter = ';';
    for (size_t last = 0, next = inputs.find(delimiter, last);
         next != std::string::npos; last = next + 1, next = inputs.find(delimiter, last))
    {
        std::istringstream iss(inputs.substr(last, next - last));
        std::vector<std::string> currLine ((std::istream_iterator<std::string>(iss)), std::istream_iterator<std::string>());
        lines.push_back(currLine);
    }
}

std::shared_ptr<Graph> Interpreter::createGraph()
{
    // preprocess source code into lines
    std::vector<std::vector<std::string> > lines;
    preprocess(lines);

    // parse each line and create edges and vertices
    for (std::vector<std::string> &oneline : lines) {
        parse(oneline);
    }
    g->setInputOutput();
    g->topoSort();
    g->setExpr();
    return g;
}

void Interpreter::parse(std::vector<std::string> &oneline)
{
    std::smatch sm;
    if (oneline[0].compare("module") == 0) {
        assert(oneline.size() >= 2);
        g->setName(oneline[1]);
    }
    else if (oneline[0].compare("input") == 0) {
        std::regex e ("\\[(\\d+):0\\]");
        if (!std::regex_match(oneline[1], sm, e))
            std::for_each(oneline.begin() + 1, oneline.end(),
                          [this](const std::string &s) {g->addInEdge(s);});
        else {
            assert(sm.size() >= 2);
            int size = stoi(sm[1]);
            assert(oneline.size() >= 3);
            std::string signalname = oneline[2];
            for (int i = 0; i <= size; ++i)
                g->addInEdge(std::string(signalname + "[" + std::to_string(i) + "]"));
        }
    }
    else if (oneline[0].compare("output") == 0) {
        std::regex e ("\\[(\\d+):0\\]");
        if (!std::regex_match(oneline[1], sm, e))
            std::for_each(oneline.begin() + 1, oneline.end(),
                          [this](const std::string &s) {g->addOutEdge(s);});
        else {
            assert(sm.size() >= 2);
            int size = stoi(sm[1]);
            assert(oneline.size() >= 3);
            std::string signalname = oneline[2];
            for (int i = 0; i <= size; ++i)
                g->addOutEdge(std::string(signalname + "[" + std::to_string(i) + "]"));
        }
    }
    // skip wire to avoid redudant signals
    else if (oneline[0].compare("wire") == 0) {
//        std::regex e ("\\[(\\d+):0\\]");
//        if (!std::regex_match(oneline[1], sm, e))
//            std::for_each(oneline.begin() + 1, oneline.end(),
//                          [this](const std::string &s) {g->getEdge(s);});
//        else {
//            assert(sm.size() >= 2);
//            int size = stoi(sm[1]);
//            assert(oneline.size() >= 3);
//            std::string signalname = oneline[2];
//            for (int i = 0; i <= size; ++i)
//                g->getEdge(std::string(signalname + "[" + std::to_string(i) + "]"));
//        }
    }
    else if (oneline[0].compare("assign") == 0) {
        assert(oneline.size() == 3);
        std::vector<std::shared_ptr<Edge> > inEdges;
        inEdges.push_back(g->getEdge(oneline.back()));
        // use the same name for vertex and out edge
        g->addCombVertex(oneline[1], makeCombVertex(TYPESMAP.at(oneline[0]), oneline[1], inEdges, g->getEdge(oneline[1])));
    }
    // For other types of gates
    else if (oneline[0].compare("endmodule")){
        assert(oneline.size() >= 4 && oneline.size() % 2 == 0);
        std::transform(oneline[0].begin(), oneline[0].end(), oneline[0].begin(), ::tolower);
        for (auto &type : TYPESMAP)
            if (oneline[0].find(type.first) == 0) 
                oneline[0] = type.first;
        // check for unsupported gates
        if (TYPESMAP.count(oneline[0]) == 0)
            throw "Gate type " + oneline[0] + " not supported";
        oneline[0] = TYPESMAP.at(oneline[0]);
        // construct inedges and outedges
        std::vector<std::shared_ptr<Edge>> inEdges;
        std::vector<std::shared_ptr<Edge>> outEdge;
        std::vector<std::string> inPorts;
        std::vector<std::string> outPort;
        for (auto it = oneline.begin() + 2; it != oneline.end(); it += 2)
        {
            std::transform(it->begin(), it->end(), it->begin(), toupper);
            std::string inPN = "", outPN = "";
            std::for_each(INPORTSNAME.begin(), INPORTSNAME.end(), [&it, &inPN](const std::string &v) {if (it->find(v) == 0) inPN = v;});
            std::for_each(OUTPORTSNAME.begin(), OUTPORTSNAME.end(), [&it, &outPN](const std::string &v) {if (it->find(v) == 0) outPN = v;});
            if (!inPN.empty()) {
                inPorts.push_back(inPN);
                inEdges.push_back(g->getEdge(*(it+1)));
            } else if (!outPN.empty()) {
                outPort.push_back(outPN);
                outEdge.push_back(g->getEdge(*(it+1)));
            } else {
                throw "unsupported port type " + (*it);
            }
        }
        
        // construct gate
        if (oneline[0].compare("dff") == 0)
            g->addSeqVertex(oneline[1], makeSeqVertex(oneline[1], inPorts, inEdges, outPort, outEdge));
        else {
            assert(outEdge.size() == 1);
            g->addCombVertex(oneline[1], makeCombVertex(oneline[0], oneline[1], inEdges, outEdge[0]));
        }
    }
}


const std::unordered_map<std::string, Interpreter::MKVERTEXFUN> Interpreter::MKFUN = {
    {"idt", &Interpreter::makeIdtCombVertex},
    {"not", &Interpreter::makeNotCombVertex},
    {"and", &Interpreter::makeAndCombVertex},
    {"nand", &Interpreter::makeNandCombVertex},
    {"or", &Interpreter::makeOrCombVertex},
    {"nor", &Interpreter::makeNorCombVertex},
    {"xor", &Interpreter::makeXorCombVertex},
    {"nxor", &Interpreter::makeNxorCombVertex}
};

std::shared_ptr<Vertex> Interpreter::makeCombVertex(const std::string& type, const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    if (MKFUN.count(type) == 0)
        throw type + " not supported";
    std::shared_ptr<Vertex> v = MKFUN.at(type)(name, inEdges, outEdge);
    outEdge->setFromNode(v);
    for (auto edg : inEdges)
        edg->addToNodes(v);
    return v;
}

std::shared_ptr<Vertex> Interpreter::makeIdtCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<IdtCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<Vertex> Interpreter::makeNotCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<NotCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<Vertex> Interpreter::makeAndCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<AndCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<Vertex> Interpreter::makeNandCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<NandCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<Vertex> Interpreter::makeOrCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<OrCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<Vertex> Interpreter::makeNorCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<NorCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<Vertex> Interpreter::makeXorCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<XorCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<Vertex> Interpreter::makeNxorCombVertex(const std::string& name, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::shared_ptr<Edge>& outEdge)
{
    return std::make_shared<NxorCombVertex>(name, inEdges, outEdge);
}

std::shared_ptr<SeqVertex> Interpreter::makeSeqVertex(const std::string& name, const std::vector<std::string> &inPorts, const std::vector<std::shared_ptr<Edge> >& inEdges, const std::vector<std::string>& outPort, const std::vector<std::shared_ptr<Edge>>& outEdge)
{
    assert(inPorts.size() == inEdges.size());
    // at most two output edges, ".Q" and ".QN"
    assert(outEdge.size() <= 2);
    auto dataIter = std::find(inPorts.begin(), inPorts.end(), ".DIN");
    if (dataIter == inPorts.end())
        throw "Seq gates with no data edge";
    std::shared_ptr<Edge> dataEdge = inEdges[dataIter - inPorts.begin()];
    std::shared_ptr<Edge> scanInEdge = g->getEdge(name);
    std::shared_ptr<SeqVertex> v;
    if (outEdge.size() == 1)
        v = std::make_shared<SeqVertex>(name, inPorts, inEdges, outPort[0], outEdge[0], dataEdge, scanInEdge);
    else
        v = std::make_shared<SeqVertex>(name, inPorts, inEdges, outPort[0], outEdge[0], dataEdge, scanInEdge, outPort[1], outEdge[1]);
    for (auto edg : outEdge)
        edg->setFromNode(v);
    for (auto edg : inEdges)
        edg->addToNodes(v);
    return v;
}
