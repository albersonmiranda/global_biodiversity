### SCRIPT TO PREPARE `BIODIVERSITY` DATASET ###


# decompress the data
untar("data-raw/biodiversity-data.tar.gz", exdir = "data-raw")

# load the data
biodiversity <- data.table::fread("data-raw/biodiversity-data/occurence.csv")
