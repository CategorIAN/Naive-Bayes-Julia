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
    classes::Vector{String}
    function MLData(name::String, data_loc::String, columns::Vector{String}, target_name::String, replace::Union{Int,Nothing}, classification::Bool)
        df = CSV.read(data_loc, DataFrame)
        return new(name, data_loc, df, columns, target_name, columns, replace, classification, [])
    end
end

end