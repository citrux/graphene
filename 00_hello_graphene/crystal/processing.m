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
        AppendTo[result,perm[data[[i]], 2 result[[-1]] - result[[-2]]]],
        {i, 3, Length[data]}];
    Transpose[result]]

Ef = -0.18609;
Ha = 27.211;
con[x_] := (x+Ef) * Ha;
data1 = Reverse[Map[Reverse, Import["1.csv","CSV"]]];
data2 = Map[Reverse, Import["2.csv","CSV"]];
data1 = Map[Map[con, #]&, data1]
data2 = Map[Map[con, #]&, data2]
bands1 = Map[Reverse, bands[data1]];
bands2 = bands[data2];
result = {};
Do[AppendTo[result,Join[bands1[[i]], bands2[[i]]]], {i, {2,5,6,7,8}}];
Export["bands.png",
        ListLinePlot[result, PlotRange -> All],
        ImageSize->{800,600}];
Export["cry.csv", result];