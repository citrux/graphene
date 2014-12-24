#!/usr/bin/WolframScript -script

var = ToExpression[Rest[$ScriptCommandLine]];
fname = var[[0]];
sep = var[[1]];

select[s_] := StringMatchQ[s, RegularExpression["^\\s*-?\\d+.*"]];

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

data = import[ReadList[fname]];
data1 = data[;;sep]
data2 = data[sep+1;;]

Export["GM.csv", data1];
Export["GK.csv", data2];