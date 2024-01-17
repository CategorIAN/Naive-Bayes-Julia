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

function getF(ml::MLData, df::DataFrame, p::Number, m::Int, Q::DataFrame)
    function g(j::Int)
        gdf = groupby(df, [:Class, Symbol(ml.features[j])])
        F = combine(gdf, nrow => "F_Count")
        pretty_table(Q)
        pretty_table(F)
        Q2 = select(Q, :Class, :Count => "Q_Count")
        pretty_table(Q2)
        F2 = innerjoin(F, Q2; on = :Class)
        pretty_table(F2)
        println(size(ml.features))
        F3 = transform(F2, [:F_Count, :Q_Count] => ByRow((f, q) -> (f + 1 + m * p) / (q + length(ml.features) + m)) => "F")
        pretty_table(F3)

        #Fcol = Fframe.index.to_series().map(lambda t: (Fframe["Count"][t] + 1 + m * p)/ (Qframe.at[t[0], "Count"] + len(self.data.features) + m))
        return F
    end
    return g
end
end