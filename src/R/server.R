library(duckdb)

# Load modules
source("R/app_home.R")
source("R/app_dataset.R")
source("R/app_map.R")

# Server
app_server <- function(input, output, session) {
  # Home module
  app_home_server("home", session)

  # db connection
  con <- dbConnect(duckdb::duckdb(), dbdir = "data/db.duckdb", read_only = TRUE)
  onStop(function() dbDisconnect(con))

  # dataset module
  app_dataset_server("dataset", con)

  # Map module
  app_map_server("maps", con)

  app_timeline_server("timeline", con)
}
