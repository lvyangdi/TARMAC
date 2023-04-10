from os import system

bench = 'c2670'
nvecs = 5000
ntriggers = 4
nrandom = 100000
ninst = 1000
rareness = 0.1

cmd = "./tarmac {0} {1} {2} {3} {4} {5} MERO".format(bench, nrandom, ntriggers, ninst, nvecs, rareness)
print(cmd)
system(cmd)

cmd = "./tarmac {0} {1} {2} {3} {4} {5} TARMAC".format(bench, nrandom, ntriggers, ninst, nvecs, rareness)
print(cmd)
system(cmd)
