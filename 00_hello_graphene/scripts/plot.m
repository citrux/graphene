#!/usr/bin/WolframScript -script

ab = Import["abinit.csv"];
qe = Import["qe.csv"];
cr = Import["cry.csv"];
result = Join[ab,qe,cr];
Export["bands.png",
        ListLinePlot[result, PlotRange -> All],
        ImageSize->{800,600}];