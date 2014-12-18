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

data = import[Import["grapheneo_DS2_EIG", "List"]];
Export["bands.png",
        ListLinePlot[bands[data], DataRange -> {0, 30}, PlotRange -> All],
        ImageSize->{800,600}];