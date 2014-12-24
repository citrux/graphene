#!/usr/bin/WolframScript -script

var = Rest[$ScriptCommandLine];
fname = var[[1]];
sep = ToExpression[var[[2]]];
headLines = ToExpression[var[[3]]];
headCols = ToExpression[var[[4]]];

select[s_] := StringMatchQ[s, RegularExpression["^\\s*-?\\d+\\.\\d+\\s+\\d.*"]];

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

data = import[Import[fname, "List", HeaderLines->headLines]];
data1 = data[[;;sep, headCols+1;;]]
data2 = data[[sep+1;;, headCols+1;;]]

Export["GM.csv", data1];
Export["GK.csv", data2];