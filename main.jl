module Main
include("DataDictionary.jl")
include("NaiveBayes.jl")
import Pkg; Pkg.add("DataFrames"); Pkg.add("CSV"); Pkg.add("PrettyTables")
using CSV
using DataFrames
using PrettyTables


function main()
    S = DataDictionary.dataobject("SoyBean")
    df = NaiveBayes.binned(S.df, 5)
    CSV.write("df.csv", df)
end


main()
end