import re

Ha = 27.211

with open("graphene.bands.out", "r") as f:
    lines = f.readlines()

data = []

flag = False
for line in lines:
    if flag and re.match("\s*-?\d+\.\d+.*", line):
        data.append(list(map(float, line.split())))
    if re.match("^\s+End of band structure calculation.*$", line):
        flag = True
    if re.match("^\s+Writing output data file graphene.save.*$", line):
        break

out = ["%d %f %f\n" % (i, line[3] / Ha, line[4] / Ha)
        for i, line in enumerate(data)]

with open("qe.dat", "w") as f:
    f.writelines(out)
