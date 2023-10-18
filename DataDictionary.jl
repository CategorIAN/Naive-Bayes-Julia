module DataDictionary

function soybean()
    name = "SoyBean"
    file = "raw_data/soybean-small.csv"
    columns = [
        "Date", 
        "Plant-Stand", 
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
        "Leafspot-Size", 
        "Leaf-Shred",
        "Leaf-Malf",
        "Leaf-Mild",
        "Stem",
        "Lodging",
        "Stem-Cankers",
        "Canker-Lesion",
        "Fruiting-Bodies",
        "External Decay",
        "Mycelium"
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