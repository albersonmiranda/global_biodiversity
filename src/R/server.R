library(shiny)

app_server <- function(input, output, session) {
  # ! homepage server logic ! #
  # make the tab active, preventing getting stuck
  observeEvent(input$maps, {
    updateTabItems(session, "tabs", "maps")
  })
  observeEvent(input$dataset, {
    updateTabItems(session, "tabs", "dataset")
  })
  observeEvent(input$about, {
    updateTabItems(session, "tabs", "about")
  })

  # ! dataset server logic ! #
  # gets uniques of countryCode
  output$country_code <- renderUI({
    query <- "SELECT DISTINCT countryCode FROM occurence"
    country_codes <- dbGetQuery(con, query)$countryCode
    shinyWidgets::pickerInput(
      inputId = "country_code",
      label = "Country Code",
      choices = country_codes,
      selected = c("PL"),
      options = list(
        `actions-box` = TRUE,
        `live-search` = TRUE,
        `live-search-placeholder` = "Search",
        `none-selected-text` = "Select Fields",
        `tick-icon` = "",
        `virtual-scroll` = 10,
        `size` = 6
      )
    )
  })

  # Observe changes in country_code and update combined_name accordingly
  observeEvent(input$country_code, {
    output$combined_name <- renderUI({
      query <- paste0(
        "SELECT DISTINCT scientificName, vernacularName FROM occurence WHERE countryCode = '",
        input$country_code,
        "'"
      )
      results <- dbGetQuery(con, query)
      combined_names <- unique(c(results$scientificName, results$vernacularName))
      shinyWidgets::pickerInput(
        inputId = "combined_name",
        label = "Scientific or Vernacular Name",
        choices = combined_names,
        selected = "Corvus cornix",
        options = list(
          `actions-box` = TRUE,
          `live-search` = TRUE,
          `live-search-placeholder` = "Search",
          `none-selected-text` = "Select Fields",
          `tick-icon` = "",
          `virtual-scroll` = 10,
          `size` = 6
        )
      )
    })
  })

  # table output
  observeEvent(
    {
      input$combined_name
    },
    {
      output$dataTable <- renderDT({
        query <- "SELECT * FROM occurence"
        conditions <- list()

        if (input$combined_name != "") {
          conditions <- c(conditions, paste0(
            "(vernacularName LIKE '%", input$combined_name, "%' OR scientificName LIKE '%", input$combined_name, "%')"
          ))
        }
        if (input$country_code != "") {
          conditions <- c(conditions, paste0("countryCode LIKE '%", input$country_code, "%'"))
        }

        if (length(conditions) > 0) {
          query <- paste(query, "WHERE", paste(conditions, collapse = " AND "))
        }

        query <- paste(query, "LIMIT 100")

        data <- dbGetQuery(con, query)
        datatable(data, options = list(scrollX = '400px'))
      })
    }
  )
}
