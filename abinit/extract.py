import re

with open("grapheneo_DS2_EIG", "r") as f:
    lines = f.readlines()

data = []
prep = []

for line in lines:
    if re.match("\s+kpt#\s.*", line):
        if prep:
            data.append(prep)
            prep = []
    elif re.match("\s*-?\d+\.\d+.*", line):
        prep += [float(s) for s in line.split()]

new_data = data[:2]
for i in range(len(data) - 2):
    pr = [2 * new_data[-1][j] - new_data[-2][j]
            for j in range(len(data[0]))]
    new_data.append(data[i+2])
    for j, el in enumerate(pr):
        mp = j
        mv = abs(new_data[-1][j] - el)
        for k, d in enumerate(new_data[-1][j:]):
            if abs(d - el) < mv:
                mp = k + j
                mv = abs(d - el)
        new_data[-1][j], new_data[-1][mp] = new_data[-1][mp], new_data[-1][j]




out = [str(i) + " " + " ".join(str(e) for e in line) + "\n"
        for i, line in enumerate(new_data)]

with open("abi.dat", "w") as f:
    f.writelines(out)
