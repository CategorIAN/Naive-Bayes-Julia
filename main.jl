module Main
include("DataDictionary.jl")
include("NaiveBayes.jl")
import Pkg; Pkg.add("DataFrames"); Pkg.add("CSV"); Pkg.add("PrettyTables")
using DataFrames
using CSV
using PrettyTables

function print_gdf(gdf)
    for (k, v) in pairs(gdf)
        println("================")
        println("For key $k:")
        pretty_table(v)
    end
end


function main(i)
    ml = DataDictionary.dataobject("SoyBean")
    println(typeof(ml))
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
        println("=========================")
        Q = NaiveBayes.getQ(df)
        pretty_table(Q)
        println("=========================")
        F_func = NaiveBayes.getF(ml, df, 0.1, 1, Q)
        F = F_func(1)
        print_gdf(F)
    end
end

main(4)
end