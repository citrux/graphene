#!/usr/bin/WolframScript -script

select[s_] := StringMatchQ[s, RegularExpression["\\s+-?\\d+.*"]];

convert[s_] := ReadList[StringToStream[s], Number];

import[lst_] := Module[{data},
    data = {{}};
    Do[
        If[select[i],
            data[[-1]] = Join[data[[-1]], convert[i]],
            If[data[[-1]] != {},
                data = Append[data, {}]]],
        {i, lst}];
    data]

perm[data_, p_, nband_] := Module[{a},
    a = data;
    Do[
        Do[
            If[ Abs[a[[j]] - p[[i]]] < Abs[a[[i]] - p[[i]]],
                {a[[i]], a[[j]]}={a[[j]], a[[i]]}],
            {j, i, Length[p]}],
        {i, nband}];
    a]

bands[data_] := Module[{result},
	result = data[[;;2]];
    Do[
        AppendTo[result,perm[data[[i]], 2 result[[-1]] - result[[-2]], Length[result[[-1]]]]],
        {i, 3, Length[data]}];
    Transpose[result]]

data = import[Import["grapheneo_DS2_EIG", "List"]];
data1 = Map[Reverse, data[[;;51]]];
data2 = Map[Reverse, data[[52;;]]];
bands1 = Map[Reverse, bands[data1]];
bands2 = bands[data2];
result = {};
Do[AppendTo[result,Join[bands1[[i]], bands2[[i]]]], {i, {3, 19, 20, 21, 22}}];
Export["bands.png",
        ListLinePlot[result, PlotRange -> All],
        ImageSize->{800,600}];