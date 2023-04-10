//
//  edge.cpp
//  test
//
//  Created by Yangdi Lyu on 1/1/19.
//  Copyright © 2019 Yangdi Lyu. All rights reserved.
//

#include "edge.h"
#include "vertex.h"

z3::context Edge::c;
unsigned int Edge::bv_size = 1;

void Edge::setBVConst() {
    e = c.bv_const(name.c_str(), bv_size);
}

void Edge::setBVVal(unsigned int val) {
    e = c.bv_val(val, bv_size);
}

bool Edge::solve(int val) {
    assert (val == 0 || val == 1);
    z3::solver s(c);
    s.add(e == val);
    return (s.check() == z3::sat);
}

bool Edge::solve(int val, std::unordered_map<std::string, int> &assign) {
    assert (val == 0 || val == 1);
    z3::solver s(c);
    s.add(e == val);
    if (s.check() == z3::sat) {
        z3::model m = s.get_model();
        for (unsigned i = 0; i < m.size(); ++i) {
            z3::func_decl v = m[i];
            assign[v.name().str()] = m.get_const_interp(v).get_numeral_int();
        }
        return true;
    }
    return false;
}

bool Edge::satisfiable(std::unordered_set<std::shared_ptr<Edge> > &triggers, std::unordered_map<std::string, int> &assign) {
    z3::solver s(c);
    for (auto &edg : triggers)
        s.add(edg->e == edg->lowProbVal);
    if (s.check() == z3::sat) {
        z3::model m = s.get_model();
        assign.clear();
        for (unsigned i = 0; i < m.size(); ++i) {
            z3::func_decl v = m[i];
            assign[v.name().str()] = m.get_const_interp(v).get_numeral_int();
        }
        return true;
    }
    return false;
}

