perm[v_, p_] := Module[{a},
    a = v;
    Do[
        Do[
            If[ ((a[[j-1]] - p[[j-1]])^2 + (a[[j]] - p[[j]])^2) > ((a[[j-1]] - p[[j]])^2 + (a[[j]] - p[[j-1]])^2),
                {a[[j-1]], a[[j]]} = {a[[j]], a[[j-1]]}],
            {j, 2, Length[p]}],
        {i, Length[p]}];
    a]

bands[data_] := Module[{result},
    result = data[[;;2]];
    Do[
        AppendTo[result,
                 perm[data[[i]], 2 result[[-1]] - result[[-2]]]],
        {i, 3, Length[data]}];
    Transpose[result]]

exportBands[bands_, prefix_] := Module[{},
    Export[prefix <> ".pdf",
        ListLinePlot[bands, PlotRange -> All],
        ImageSize->{800,600}];
    Export[prefix <> ".csv", bands];]

Profit[data_, prefix_] := exportBands[bands[data], prefix]