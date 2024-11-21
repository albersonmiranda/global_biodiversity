library(leaflet)

app_map_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    titlePanel("Biodiversity Map"),
    fluidRow(
      column(12, uiOutput(ns("map_country_code"))),
      column(12, uiOutput(ns("map_combined_name")))
    ),
    fluidRow(
      column(12, withSpinner(leafletOutput(ns("map"))))
    )
  )
}

app_map_server <- function(id, con) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$map_country_code <- renderUI({
      showModal(
        modalDialog(
          title = "Welcome to the Biodiversity Map",
          "Please select a country and a scientific or vernacular name to view the map.",
          easyClose = TRUE,
          footer = NULL
        )
      )
      query <- "SELECT DISTINCT country FROM occurence"
      country_codes <- dbGetQuery(con, query)$country
      shinyWidgets::pickerInput(
        inputId = ns("map_country_code"),
        label = "Country Code",
        choices = country_codes,
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

    observeEvent(input$map_country_code, {
      sanitized_map_country_code <- gsub("'", "", input$map_country_code)
      output$map_combined_name <- renderUI({
        query <- paste0(
          "SELECT DISTINCT scientificName, vernacularName FROM occurence WHERE country IN ('",
          paste(sanitized_map_country_code, collapse = "','"),
          "')"
        )
        results <- dbGetQuery(con, query)
        combined_names <- unique(c(results$scientificName, results$vernacularName))
        shinyWidgets::pickerInput(
          inputId = ns("map_combined_name"),
          label = "Scientific or Vernacular Name",
          choices = combined_names,
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

    observeEvent(input$map_combined_name, {
      output$map <- renderLeaflet({
        query <- "SELECT * FROM occurence"
        conditions <- list()

        if (!is.null(input$map_country_code)) {
          country_conditions <- paste0("country IN ('", paste(input$map_country_code, collapse = "','"), "')")
          conditions <- c(conditions, country_conditions)
        }

        if (!is.null(input$map_combined_name)) {
          name_conditions <- paste0(
            "(scientificName IN ('", paste(input$map_combined_name, collapse = "','"), "') OR ",
            "vernacularName IN ('", paste(input$map_combined_name, collapse = "','"), "'))"
          )
          conditions <- c(conditions, name_conditions)
        }

        if (length(conditions) > 0) {
          query <- paste(query, "WHERE", paste(conditions, collapse = " AND "))
        }

        data <- dbGetQuery(con, query)

        unique_names <- unique(data$scientificName)
        colors <- RColorBrewer::brewer.pal(length(unique_names), "Set1")
        pal <- colorFactor(colors, unique_names)

        leaflet(data) %>%
          addProviderTiles("CartoDB.Positron") %>%
          addCircleMarkers(
            lng = ~longitudeDecimal,
            lat = ~latitudeDecimal,
            popup = ~scientificName,
            color = ~ pal(scientificName),
            radius = 5
          )
      })
    })
  })
}
