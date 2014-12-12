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

data = import[Import["grapheneo_DS2_EIG", "List"]];
Export["bands.pdf",
        ListLinePlot[Transpose[data], DataRange -> {0, 30}, PlotRange -> All]]
