module NaiveBayes
import Pkg; Pkg.add("CategoricalArrays")
using DataFrames
using CategoricalArrays
function binned(df::DataFrame, b::Int)
    function f(col::String)
        try
            colvalues = convert.(Int, df[!, col])
            return cut(colvalues, b)
        catch e
            println("Sorry")
        end
    end
    colvalues = convert.(Int, df[!, "Temp"])
    minval = minimum(colvalues); maxval = maximum(colvalues); step = (maxval - minval) / b
    println(minval)
    println(maxval)
    println(step)
    println(minval:step:(maxval))
    return cut(colvalues, minval:step:(maxval), labels = 1:5, allowempty=true, extend = true)
    #return f("Temp")
end
end