library(plotly)
library(shinyWidgets)

app_timeline_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    titlePanel("Species Observation Timeline"),
    tags$h4("Please select a country and a scientific or vernacular name to view the timeline"),
    fluidRow(
      column(12, uiOutput(ns("timeline_country_code"))),
      column(12, uiOutput(ns("timeline_combined_name")))
    ),
    fluidRow(
      column(12, withSpinner(plotlyOutput(ns("timeline_plot")), caption = "Awaiting country and species selection"))
    )
  )
}

app_timeline_server <- function(id, con) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$timeline_country_code <- renderUI({
      query <- "SELECT DISTINCT country FROM occurence"
      timeline_country_codes <- dbGetQuery(con, query)$country
      shinyWidgets::pickerInput(
        inputId = ns("timeline_country_code"),
        label = "Country",
        choices = sort(timeline_country_codes),
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

    # Fetch species list dynamically
    observeEvent(input$timeline_country_code, {
      sanitized_timeline_country_code <- gsub("'", "", input$timeline_country_code)
      output$timeline_combined_name <- renderUI({
        query <- paste0(
          "SELECT DISTINCT scientificName, vernacularName FROM occurence WHERE country IN ('",
          paste(sanitized_timeline_country_code, collapse = "','"),
          "')"
        )
        results <- dbGetQuery(con, query)
        combined_names <- unique(c(results$scientificName, results$vernacularName))
        shinyWidgets::pickerInput(
          inputId = ns("timeline_combined_name"),
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

    # Render timeline plot
    observeEvent(input$timeline_combined_name, {
      output$timeline_plot <- renderPlotly({
        req(input$timeline_combined_name)

        query <- "SELECT eventDate, scientificName, vernacularName FROM occurence"
        conditions <- list()

        if (!is.null(input$timeline_country_code)) {
          country_conditions <- paste0("country IN ('", paste(input$timeline_country_code, collapse = "','"), "')")
          conditions <- c(conditions, country_conditions)
        }

        if (!is.null(input$timeline_combined_name)) {
          name_conditions <- paste0(
            "(scientificName IN ('", paste(input$timeline_combined_name, collapse = "','"), "') OR ",
            "vernacularName IN ('", paste(input$timeline_combined_name, collapse = "','"), "'))"
          )
          conditions <- c(conditions, name_conditions)
        }

        if (length(conditions) > 0) {
          query <- paste(query, "WHERE", paste(conditions, collapse = " AND "))
        }

        data <- dbGetQuery(con, query)

        # Process data for visualization
        data$eventDate <- as.Date(data$eventDate)
        timeline_data <- aggregate(data$scientificName, by = list(data$eventDate, data$scientificName), FUN = length)
        names(timeline_data) <- c("eventDate", "scientificName", "observation_count")

        # Create timeline plot
        plot_ly(
          data = timeline_data,
          x = ~eventDate,
          y = ~observation_count,
          color = ~scientificName,
          type = "scatter",
          mode = "lines",
          hoverinfo = "text",
          text = ~ paste("Species:", scientificName, "<br>Observations:", observation_count)
        ) |>
          layout(
            title = "Species Observation Timeline",
            xaxis = list(title = "Date", range = c(as.Date("2010-01-01"), max(timeline_data$eventDate))),
            yaxis = list(title = "Number of Observations"),
            legend = list(title = list(text = "Species"))
          )
      })
    })
  })
}
