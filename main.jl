module Main
include("DataDictionary.jl")
include("NaiveBayes.jl")
include("MLData.jl")
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
    df = NaiveBayes.binned(ml.df, 5)
    p = 0.1
    m = 1
    Q = NaiveBayes.getQ(df)
    Q_d = Dict(zip(Q.Class, Q.Q))
    if i == 1
        CSV.write("df_binned.csv", df)
    end
    if i == 2
        Q = NaiveBayes.getQ(df)
        println(typeof(Q[1, :]))
    end
    if i == 3
        F = NaiveBayes.getF(ml, df, 0.1, 1, NaiveBayes.getQ(df))(1)
        pretty_table(F)
    end
    if i == 4
        Fs = NaiveBayes.getFs(ml, df, 0.1, 1, NaiveBayes.getQ(df))
        for j in 1:length(ml.features)
            println("Feature: $(ml.features[j])")
            pretty_table(Fs[j])
        end
    end
    if i == 5
        x = df[1, Not(:Class)]  #Has Class D1.
        T = NaiveBayes.class_prob(ml, df, p, m, Q)("D1", x)
        println(T)
    end
end

main(5)
end