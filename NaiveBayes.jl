module NaiveBayes
import Pkg; Pkg.add("CategoricalArrays"); Pkg.add("PrettyTables")
include("MLData.jl")
using DataFrames
using CategoricalArrays
using PrettyTables
using ..DataDictionary.MLDataModule: MLData

function binned(df::DataFrame, b::Int)
    function f(col::String)
        try
            colvalues = convert.(Int, df[!, col])
            minval = minimum(colvalues); maxval = maximum(colvalues); step = (maxval - minval) / b
            return cut(colvalues, minval:step:maxval, labels = 1:b, allowempty = true, extend = true)
        catch e
            return df[!, col]
        end
    end
    return DataFrame(Dict(col => f(col) for col in names(df)))
end

function getQ(df::DataFrame)
    return  combine(groupby(df, :Class), nrow => "Count", proprow => "Q")
end

function getF(ml::MLData, df::DataFrame, p::Number, m::Int, Qframe::DataFrame)
    function g(j::Int)
        println("The Dataframe:")
        pretty_table(df)
        s = ml.features[j]
        println("The Feature is $s.")
        println("The Grouped Dataframe")
        gdf = groupby(df, ["Class", s])

        #Fframe = combine(groupby(df, [:Class, :s]), nrow => "Count")
        #Fframe = pd.DataFrame(df.groupby(by=["Class", self.data.features[j]])["Class"].agg("count")).rename(columns={"Class": "Count"})
        #return Fframe
        return gdf
    end
    return g
end
end