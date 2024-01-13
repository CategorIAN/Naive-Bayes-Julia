module Main
include("DataDictionary.jl")
include("NaiveBayes.jl")
import Pkg; Pkg.add("DataFrames"); Pkg.add("CSV"); Pkg.add("PrettyTables")
using DataFrames
using CSV
using PrettyTables


function main(i)
    ml = DataDictionary.dataobject("SoyBean")
    df = NaiveBayes.binned(ml.df, 5)
    if i == 1
        CSV.write("df_binned.csv", df)
    end
    if i == 2
        for (k, v) in NaiveBayes.getQ(df)
            println(k)
            pretty_table(v)
        end
    end
    if i == 3
        pretty_table(NaiveBayes.getQ(df))
    end
    if i == 4
        Q = NaiveBayes.getQ(df)
        F = NaiveBayes.getF(ml, df, 0.1, 1, Q)(1)
        pretty_table(F)
    end
end


main(4)
end