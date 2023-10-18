module MLData
using DataFrames
using csv

struct MLData
    name::String
    data_loc::String
    df::DataFrame
    columns::Vector{String}
    target_name::String
    features::Vector{String}
    replace::Int
    classification::Bool
    classes::Vector{String}
    function MLData(name::String, data_loc::Int, columns::Vector{String}, target_name::String, replace::Int, classification::Bool)
        df = CSV.read(data_loc, DataFrame)
        return new(name, data_loc, df, columns, target_name, features, replace, classification, [])
    end
end

end