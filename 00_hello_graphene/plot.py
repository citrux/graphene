from matplotlib import pyplot as plt
import csv

plt.rc('text', usetex=True)
plt.rc('text.latex', unicode=True)
plt.rc('text.latex', preamble=r'\usepackage[russian]{babel}')

with open('abinit.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile)
    ab = [[float(i) for i in row] for row in spamreader]

with open('qe.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile)
    qe = [[float(i) for i in row] for row in spamreader]

with open('cry.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile)
    cr = [[float(i) for i in row] for row in spamreader]

x = True
for l in ab:
    if x:
        plt.plot(l, "k-", label="ABINIT")
        x = False
    else:
        plt.plot(l, "k-")

x = True
for l in qe:
    if x:
        plt.plot(l, "k--", label="QUANTUM ESPRESSO")
        x = False
    else:
        plt.plot(l, "k--")
x = True
for l in cr:
    if x:
        plt.plot(l, "k:", label="CRYSTAL")
        x = False
    else:
        plt.plot(l, "k:")

plt.xticks([0, 50, 97], ["$M$", "$\Gamma$", "$K$"])
plt.xlim([0, 97])
plt.ylim([-25, 20])
plt.legend()
plt.ylabel("Энергия, эВ")
plt.savefig("res.pdf")