//
//  Created by Yangdi Lyu on 12/31/18.
//  Copyright © 2018 Yangdi Lyu. All rights reserved.
//

#include <iostream>
#include <string>
#include <fstream>
#include <streambuf>
#include <string>
#include <random>
#include <unistd.h>
#include <sys/stat.h>
#include <chrono>
#include "graph.h"
#include "vertex.h"
#include "edge.h"
#include "interpreter.h"
#include "visitor.h"

/*
 * read vector from file
 * each line represent a vector
 * vecs: returned vectors
 */
void readVectorsFromFile(std::string filename, std::vector<std::string> &vecs);

/*
 * generate random vectors
 * length: size of each vector
 * patterns: total number of vectors
 */
void genRandVectors(std::string filename, size_t length, unsigned int patterns);

/*
 * create folder
 * return -1 if failed
 */
int createfolder(std::string foldername);

int main(int argc, char* argv[]) {
    if (argc < 8) {
        std::cerr << "Usage: " << argv[0] << " benchmark numRand numTriggers numTrojans numVectors trigthresh tool\n";
        return 1;
    }
    std::string bench = argv[1];
    unsigned int numRand = std::stoi(argv[2]);
    unsigned int numTriggers = std::stoi(argv[3]);
    unsigned int numTrojans = std::stoi(argv[4]);
    unsigned int numVectors = std::stoi(argv[5]);
    std::string threshold = argv[6];
    std::string tool = argv[7];
    const unsigned int Ndetect = 1000;
    
    std::string testFolder = "tests";
    std::string debugFolder = "Debug";
    std::string trojanFolder = "Trojans_theta_" + threshold;
    std::string benchFolder = "benchmarks";

    if (createfolder(testFolder) == -1 ||
        createfolder(trojanFolder) == -1 ||
        createfolder(debugFolder) == -1)
        return -1;
    
    srand(0);
    
    Interpreter a(benchFolder + "/" + bench + ".v");
    auto start = std::chrono::system_clock::now();
    std::shared_ptr<Graph> g = nullptr;
    try {
        g = a.createGraph();
    } catch (std::string errormsg)
    {
        std::cerr << errormsg << std::endl;
        return 1;
    }
    auto end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed_seconds = end - start;
    std::cout << "create graph (topo sorting, SAT expression) time: " << elapsed_seconds.count() << "s\n";

    std::vector<std::string> randvecs;
    std::string randFileName = testFolder + "/rand" + std::to_string(numRand) + "_PI_" + bench + ".txt";
    genRandVectors(randFileName, g->inEdges.size(), numRand);
    std::cout << "reading vectors from " + randFileName + "\n";
    readVectorsFromFile(randFileName, randvecs);
    
    std::string vecFileName = testFolder + "/" + tool + "_PI_" + bench + "_N1000_" + threshold + ".txt";
    Visitor vst(g, vecFileName, std::stof(threshold));
    std::string nodeFileName = debugFolder + "/" + bench + "_nodes_" + threshold + ".txt";
    struct stat buffer;
    if (stat(nodeFileName.c_str(), &buffer) == 0) {
        std::cout << "Low prob nodes file exist. Skip simulation.\n";
        std::cout << "Reading low prob nodes from file " << nodeFileName << std::endl;
        vst.readLowNodes(nodeFileName);
    } else {
        std::cout << "Start simulation with random vectors.\n";
        if (std::stof(threshold) > 1) {
            // select the rarest $threshold edges
            std::cout << "\tSelecting the " << threshold << " rarest signals\n";
            vst.generateStat(randvecs, std::stoi(threshold));
        } else {
            // select the rare edges lower than $threshold
            std::cout << "\tSelecting rare signals (activation probability less than threshold: " << threshold << " )\n";
            vst.generateStat(randvecs);
        }
        std::cout << "Dumping low prob nodes to file " << nodeFileName << std::endl;
        vst.dumpLowNodes(nodeFileName);
    }

    std::cout << "\n\nNumber of patterns: " << randvecs.size() << std::endl;
    std::cout << "\n\nGraph Statistics ...\n";
    std::cout << "Graph comb vertices: " << g->combGates.size() << std::endl;
    std::cout << "Number of flip-flops: " << g->seqGates.size() << std::endl;
    std::cout << "Graph Edges: " << g->edgArr.size() - g->seqGates.size() << std::endl;
    std::cout << "Number of low prob edges: " << vst.lowprobEdges.size() << std::endl;

    vst.generateTrojan(trojanFolder + "/" + bench + ".v_" + std::to_string(numTriggers) + ".trojans_" + std::to_string(numTrojans), numTriggers, numTrojans, !tool.compare("asset"));

    start = std::chrono::system_clock::now();
    
    std::vector<std::string> vecs;
    if (stat(vecFileName.c_str(), &buffer) == 0) {
        std::cout << "Reading " << tool << " vectors from file " << vecFileName << std::endl;
        readVectorsFromFile(vecFileName, vecs);
    } else if (tool.compare("MERO") == 0)
        vst.MERO(vecs, randvecs, Ndetect);
    else
        vst.TARMAC(vecs, numVectors);
    
    elapsed_seconds = std::chrono::system_clock::now() - start;
    std::cout << "test generation time: " << elapsed_seconds.count() << "s\n";
    vst.triggerSim(vecs);
    return 0;
}

void readVectorsFromFile(std::string filename, std::vector<std::string> &vecs) {
    std::ifstream fvec(filename);
    if (!fvec.is_open()) {
        throw std::string("Vector file not present: " + std::string(filename) + ". Exiting ...\n");
    }
    std::string line;
    while (fvec.good()) {
        fvec >> line;
        if (!fvec.good())    break;
        vecs.push_back(line);
    }
    fvec.close();
}

// Generate random test vectors
void genRandVectors(std::string filename, size_t length, unsigned int patterns) {
    // If file already exists, skip
    if ( access(filename.c_str(), F_OK ) != -1 ) {
        std::cout << "Random patterns: " << filename << " already exist. Skip generating...\n";
        return;
    }
    std::ofstream fout(filename);
    int blockshift = 4;
    int twopower = 1 << blockshift;
    int maxRand = (1 << twopower) - 1;
    // use better pseudo-random generator than rand() % 2
    std::mt19937 e(std::random_device{}());
    std::uniform_int_distribution<int> uniform_dist(0, maxRand);
    // generate enought bits to p
    size_t numBlock = ((length - 1) >> blockshift) + 1;
    std::string p(numBlock << blockshift, '0');
    
    std::cout << "Generating " << patterns << " random patterns in file: " << filename << " ...\n";
    
    for (unsigned int i = 0; i < patterns; ++i) {
        for (size_t j = 0; j < numBlock; ++j) {
            int r = uniform_dist(e);
            // extract 8 bits from r
            for (int k = 0; k < twopower; ++k) {
                p[(j << blockshift) + k] = (r & 1) ? '1' : '0';
                r >>= 1;
            }
        }
        
        fout << p.substr(0, length) << std::endl;
    }
    fout.close();
}

// create folder
int createfolder(std::string foldername) {
    if ((mkdir(foldername.c_str(), S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH) == -1) && (errno != EEXIST)) {
        std::cerr << "Error creating folder " << foldername << std::endl;
        return -1;
    }
    return 0;
}
