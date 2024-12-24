library(DT)
library(shinycssloaders)

app_dataset_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    titlePanel("Biodiversity Data"),
    tags$h4("Please select a country and a scientific or vernacular name to view the map"),
    fluidRow(
      column(12, uiOutput(ns("country_code"))),
      column(12, uiOutput(ns("combined_name")))
    ),
    fluidRow(
      column(12, withSpinner(DTOutput(ns("dataTable")), caption = "Awaiting country and species selection"))
    )
  )
}

app_dataset_server <- function(id, con) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$country_code <- renderUI({
      query <- "SELECT DISTINCT country FROM occurence"
      country_codes <- dbGetQuery(con, query)$country
      shinyWidgets::pickerInput(
        inputId = ns("country_code"),
        label = "Country",
        choices = sort(country_codes),
        multiple = TRUE,
        options = list(
          `actions-box` = TRUE,
          `live-search` = TRUE,
          `live-search-placeholder` = "Search",
          `none-selected-text` = "Select Country",
          `tick-icon` = "",
          `virtual-scroll` = 10,
          `size` = 6
        )
      )
    })

    observeEvent(input$country_code, {
      sanitized_country_code <- gsub("'", "", input$country_code)
      output$combined_name <- renderUI({
        query <- paste0(
          "SELECT DISTINCT scientificName, vernacularName FROM occurence WHERE country IN ('",
          paste(sanitized_country_code, collapse = "','"),
          "')"
        )
        results <- dbGetQuery(con, query)
        combined_names <- unique(c(results$scientificName, results$vernacularName))
        shinyWidgets::pickerInput(
          inputId = ns("combined_name"),
          label = "Scientific or Vernacular Name",
          choices = sort(combined_names),
          multiple = TRUE,
          options = list(
            `live-search` = TRUE,
            `live-search-placeholder` = "Search",
            `none-selected-text` = "Select species or vernacular name",
            `tick-icon` = "",
            `virtual-scroll` = 10,
            `size` = 6
          )
        )
      })
    })

    observeEvent(input$combined_name, {
      output$dataTable <- renderDT({
        query <- "SELECT * FROM occurence"
        conditions <- list()

        if (!is.null(input$country_code)) {
          country_conditions <- paste0("country IN ('", paste(input$country_code, collapse = "','"), "')")
          conditions <- c(conditions, country_conditions)
        }

        if (!is.null(input$combined_name)) {
          name_conditions <- paste0(
            "(scientificName IN ('", paste(input$combined_name, collapse = "','"), "') OR ",
            "vernacularName IN ('", paste(input$combined_name, collapse = "','"), "'))"
          )
          conditions <- c(conditions, name_conditions)
        }

        if (length(conditions) > 0) {
          query <- paste(query, "WHERE", paste(conditions, collapse = " AND "))
        }

        data <- dbGetQuery(con, query)
        datatable(data, options = list(scrollX = TRUE))
      })
    })
  })
}
