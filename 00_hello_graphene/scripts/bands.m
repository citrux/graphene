#!/usr/bin/WolframScript -script

to_print = ToExpression[Rest[$ScriptCommandLine]];

perm[data_, p_] := Module[{a},
    a = data;
    Do[
        Do[
            If[ Abs[a[[j]] - p[[i]]] < Abs[a[[i]] - p[[i]]],
                {a[[i]], a[[j]]}={a[[j]], a[[i]]}],
            {j, i, Length[p]}],
        {i, Length[p]}];
    a]

bands[data_] := Module[{result},
    result = data[[;;2]];
    Do[
        AppendTo[result,
                 perm[data[[i]], 2 result[[-1]] - result[[-2]]]],
        {i, 3, Length[data]}];
    Transpose[result]]

data1 = Map[Reverse, Import["GM.csv"]];
data2 = Map[Reverse, Import["GK.csv"]];

bands1 = Map[Reverse, bands[data1]];
bands2 = bands[data2];

result = {};
Do[AppendTo[result,Join[bands1[[i]], bands2[[i]]]], {i, to_print}];

Export["bands.png",
        ListLinePlot[result, PlotRange -> All],
        ImageSize->{800,600}];
Export["bands.csv", result];