# dataset page #

library(duckdb)
library(DT)
library(shinycssloaders)

# Connect to DuckDB
con <- dbConnect(duckdb::duckdb(), dbdir = "data/db.duckdb")

# Define UI for application
app_dataset <- fluidPage(
  titlePanel("Biodiversity Data"),
  fluidRow(
    column(12, uiOutput("combined_name")),
    column(12, uiOutput("country_code"))
  ),
  fluidRow(
    column(12, withSpinner(DTOutput("dataTable")))
  )
)
