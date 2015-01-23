select[s_] := StringMatchQ[s, RegularExpression["^\\s*-?\\d+\\.\\d+\\s+-?\\d.*"]];

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

getData[fname_, headLines_, headCols_] := Module[{data},
	data = import[Import[fname, "List", HeaderLines->headLines]];
	data = data[[;;, headCols+1;;]];
	data]

AbData[fname_] := getData[fname, 1, 0]