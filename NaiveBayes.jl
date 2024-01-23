module NaiveBayes
import Pkg; Pkg.add("CategoricalArrays"); Pkg.add("PrettyTables")
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
    return j::String-> begin
        F = combine(groupby(df, [:Class, Symbol(j)]), nrow => "F_Count")
        FjoinQ = innerjoin(F, select(Q, :Class, :Count => "Q_Count"); on = :Class)
        return transform(FjoinQ, [:F_Count, :Q_Count] => ByRow((f, q) -> (f + 1 + m * p) / (q + length(ml.features) + m)) => "F")
    end
end

function getFs(ml::MLData, df::DataFrame, p::Number, m::Int, Q::DataFrame)
    F_func = getF(ml, df, p, m, Q)
    return Dict(j => F_func(j) for j in ml.features)
end

#def class_prob(self, df, p, m, Qframe):

function class_prob(ml::MLData, df::DataFrame, p::Number, m::Int, Q::DataFrame)
    #Fframes = self.getFs(df, p, m, Qframe)
    Fs = getFs(ml, df, p, m, Q)
    Q_d = Dict(zip(Q.Class, Q.Q))
    function f(cl::String, x::DataFrameRow)
        g = (r::Number, j::String) -> begin 
        df = Fs[j]
        d = Dict(zip(zip(df.Class, df[:, Symbol(j)]), df.F))
        return r * get(d, (cl, x[j]), 0)
        end
        return foldl(g, ml.features; init=1000000)
    end

    #        def f(cl, x):
    #return reduce(lambda r, j: r * Fframes[j].to_dict()["F"].get((cl, x[j]), 0), range(len(self.data.features)), Qframe.at[cl, "Q"])
    return f
end
end