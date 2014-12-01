import re

with open("grapheneo_DS2_EIG", "r") as f:
    lines = f.readlines()

data = []

for line in lines:
    if re.match("\s*-?\d+\.\d+.*", line):
        data.append(list(map(float, line.split())))

out = ["%d %f %f\n" % (i, line[3], line[4])
        for i, line in enumerate(data)]

with open("abi.dat", "w") as f:
    f.writelines(out)
