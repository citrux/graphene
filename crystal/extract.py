import re

with open("graphene.out", "r") as f:
    c = f.read()

efermi = float(re.search(r"EFERMI\s+(-?\d\.\d+)", c).group(1))

with open("graphene_dat.BAND", "r") as f:
    lines = f.readlines()

data = list(filter(lambda i: i.startswith(" "), lines))
float_data = [[float(j) for j in i.split()] for i in data]
out = ["%d %f %f\n" % (i, line[1] + efermi, line[2] + efermi)
        for i, line in enumerate(float_data)]

with open("cry.dat", "w") as f:
    f.writelines(out)
