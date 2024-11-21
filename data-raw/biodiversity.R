### SCRIPT TO PREPARE `BIODIVERSITY` DATASET ###


# download data
download.file(
  "https://drive.usercontent.google.com/open?id=1l1ymMg-K_xLriFv1b8MgddH851d6n2sU&authuser=0",
  "data-raw/biodiversity-data.tar.gz"
)

# decompress the data
untar("data-raw/biodiversity-data.tar.gz", exdir = "data-raw")

# create and populate db
con <- DBI::dbConnect(duckdb::duckdb(), dbdir = "src/data/db.duckdb")
duckdb::duckdb_read_csv(
  con,
  "occurence",
  "data-raw/biodiversity-data/occurence.csv",
  col.types = c(
    id = "string",
    occurrenceID = "string",
    catalogNumber = "string",
    basisOfRecord = "string",
    collectionCode = "string",
    scientificName = "string",
    taxonRank = "string",
    kingdom = "string",
    family = "string",
    higherClassification = "string",
    vernacularName = "string",
    previousIdentifications = "string",
    individualCount = "integer",
    lifeStage = "string",
    sex = "string",
    longitudeDecimal = "double",
    latitudeDecimal = "double",
    geodeticDatum = "string",
    dataGeneralizations = "string",
    coordinateUncertaintyInMeters = "integer",
    continent = "string",
    country = "string",
    countryCode = "string",
    stateProvince = "string",
    locality = "string",
    habitat = "string",
    recordedBy = "string",
    eventID = "string",
    eventDate = "string",
    eventTime = "string",
    samplingProtocol = "string",
    behavior = "string",
    associatedTaxa = "string",
    references = "string",
    rightsHolder = "string",
    license = "string",
    modified = "string"
  )
)

duckdb::duckdb_read_csv(
  con,
  "multimedia",
  "data-raw/biodiversity-data/multimedia.csv",
  col.types = c(
    id = "string",
    occurrenceID = "string",
    type = "string",
    format = "string",
    identifier = "string",
    references = "string",
    rightsHolder = "string",
    license = "string",
    modified = "string"
  )
)

# leave just Europe
DBI::dbExecute(con, "DELETE FROM occurence WHERE continent NOT IN ('Europe');")

# compacting db
DBI::dbExecute(con, "
  ATTACH 'src/data/db.duckdb' AS db1;
  ATTACH 'src/data/db2.duckdb' AS db2;
  COPY FROM DATABASE db1 TO db2;
")

# replace db with compacted one
unlink("src/data/db.duckdb")
file.rename("src/data/db2.duckdb", "src/data/db.duckdb")
