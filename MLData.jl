module MLDataModule
import Pkg; Pkg.add("DataFrames"); Pkg.add("CSV")
using DataFrames
using CSV

struct MLData
    name::String
    data_loc::String
    df::DataFrame
    columns::Vector{String}
    target_name::String
    features::Vector{String}
    replace::Union{Int, Nothing}
    classification::Bool
    classes::Union{Vector{String}, Nothing}
    function MLData(name::String, data_loc::String, columns::Vector{String}, target_name::String, replace::Union{Int,Nothing}, classification::Bool)
        df = CSV.read(data_loc, DataFrame; header=false)
        rename!(df, columns)
        target_column = df[:, target_name]
        df = select(df, Not(target_name))
        features = names(df)
        insertcols!(df, (target_name => target_column))
        classes = classification ? unique(df[:, target_name]) : nothing
        return new(name, data_loc, df, columns, target_name, features, replace, classification, classes)
    end
end

end