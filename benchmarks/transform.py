import argparse
import re

parser = argparse.ArgumentParser(description='Process array in verilog file.')
parser.add_argument('filename', type=str, help='verilog file name to process')
args = parser.parse_args()

orignal = ""
whole = ""
inputsignal = []
outputsignal = []
with open(args.filename) as fin:
    inpattern1 = re.compile("input (\[(\d+):(\d+)\]) ([^;]+);")
    inpattern2 = re.compile("input ([^\[][^;]+);")
    outpattern1 = re.compile("output (\[(\d+):(\d+)\]) ([^;]+);")
    outpattern2 = re.compile("output ([^\[][^;]+);")
    for line in fin:
        orignal += line
        whole += line.strip()
    for m in inpattern1.findall(whole):
        for i in range(int(m[1]) + 1):
            inputsignal.append(m[3] + f"[{i}]")
    for m in inpattern2.findall(whole):
        inputsignal += m.split(', ')
    for m in outpattern1.findall(whole):
        for i in range(int(m[1]) + 1):
            outputsignal.append(m[3] + f"[{i}]")
    for m in outpattern2.findall(whole):
        outputsignal += m.split(', ')

t = re.sub(r'input[^;]+;', r'', whole)
t = re.sub(r'output[^;]+;', r'', t)
t = re.sub('tri', 'wire', t)
t = re.sub(r'\\\*\*FFGEN\*\* ', r'dffs1 ', t)
t = re.sub(r'\.next_state\(', '.DIN(', t)
t = re.sub(r'\.clocked_on\(', '.CLK(', t)
t = re.sub(r'AN2 ', r'and2s1 ', t)
t = re.sub(r'OR2 ', r'or2s1 ', t)
t = re.sub(r'IV ', r'hi1s1 ', t)
t = re.sub(r'\.A\(', '.DIN1(', t)
t = re.sub(r'\.B\(', '.DIN2(', t)
t = re.sub(r'\.Z\(', '.Q(', t)
t = re.sub(r'\.force_\d\d\([^\)]+\),', '', t)
t = re.sub(r'wire', "input " + ', '.join(inputsignal) + ";\n  wire", t, 1)
t = re.sub(r'wire', "output " + ', '.join(outputsignal) + ";\n  wire", t, 1)
t = re.sub(r';', ";\n  ", t)
t = re.sub(r' \[', '[', t)
print(t)
