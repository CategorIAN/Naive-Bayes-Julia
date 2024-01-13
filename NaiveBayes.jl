module NaiveBayes
import Pkg; Pkg.add("CategoricalArrays")
include("MLData.jl")
using DataFrames
using CategoricalArrays
using .MLDataModule: MLData

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
        s = ml.features[j]
        println(s)
        Fframe = combine(groupby(df, [:Class, s]), nrow => "Count")
        return Fframe
    end
    return g
end
end