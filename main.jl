module Main
include("DataDictionary.jl")
import Pkg; Pkg.add("DataFrames"); Pkg.add("CSV"); Pkg.add("PrettyTables")
using CSV
using DataFrames
using PrettyTables


function main()
    S = DataDictionary.dataobject("SoyBean")
    CSV.write("df.csv", S.df)
end


main()
end