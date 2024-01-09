module Main
include("DataDictionary.jl")
include("NaiveBayes.jl")
import Pkg; Pkg.add("DataFrames"); Pkg.add("CSV"); Pkg.add("PrettyTables")
using DataFrames
using CSV
using PrettyTables


function main(i)
    df = NaiveBayes.binned(DataDictionary.dataobject("SoyBean").df, 5)
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
end


main(3)
end