module DataDictionary
include("MLData.jl")
using .MLDataModule: MLData

datanames = ["SoyBean"]

function metadata(name::String)
    if name == "SoyBean"
        soybean()
    end
end

function dataobject(name::String)
    return MLData(metadata(name)...)
end

function soybean()
    name = "SoyBean"
    file = "raw_data/soybean-small.csv"
    columns = [
        "Date", 
        "Plant-Stand",
        "Precip",
        "Temp", 
        "Hail", 
        "Crop-Hist", 
        "Area-Damaged", 
        "Severity", 
        "Seed-TMT", 
        "Germination", 
        "Plant-Growth", 
        "Leaves", 
        "Leafspots-Halo",
        "Leafspots-Marg",
        "Leafspot-Size", 
        "Leaf-Shread",
        "Leaf-Malf",
        "Leaf-Mild",
        "Stem",
        "Lodging",
        "Stem-Cankers",
        "Canker-Lesion",
        "Fruiting-Bodies",
        "External Decay",
        "Mycelium",
        "Int-Discolor",
        "Sclerotia",
        "Fruit-Pods",
        "Fruit Spots",
        "Seed",
        "Mold-Growth",
        "Seed-Discolor",
        "Seed-Size",
        "Shriveling",
        "Roots",
        "Class"  #Target
    ]
    replace = nothing
    target_name = "Class"
    classification = true
    return (name, file, columns, target_name, replace, classification)
end

end