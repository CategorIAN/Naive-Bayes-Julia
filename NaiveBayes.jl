module NaiveBayes
import Pkg; Pkg.add("CategoricalArrays")
using DataFrames
using CategoricalArrays
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
    # I need to group the dataframe by class.
    x = groupby(df, :Class)
    return combine(x, nrow)
end
end