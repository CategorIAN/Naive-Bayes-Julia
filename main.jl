module Main
include("DataDictionary.jl")
import Pkg; Pkg.add("DataFrames"); Pkg.add("CSV")
using CSV
using DataFrames


function main()
    S = DataDictionary.dataobject("SoyBean")
    df = S.df
    println(length(S.columns))
    println(names(df))
    #CSV.write("df.csv", df)
    #DataDictionary.soybean()
end


main()
end