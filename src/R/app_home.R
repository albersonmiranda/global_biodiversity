app_home_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      class = "home-title",
      tags$p("GBIF | Global Biodiversity Information Facility"),
      tags$h1("Free and open access to biodiversity data")
    ),
    actionButton(ns("go_to_dataset"), "Go to Dataset", class = "button button-dataset", icon = icon("database")),
    actionButton(ns("go_to_maps"), "Go to Maps", class = "button button-maps", icon = icon("map")),
    actionButton(ns("go_to_timeline"), "Go to Timeline", class = "button button-timeline", icon = icon("chart-line"))
  )
}

app_home_server <- function(id, global_session) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$go_to_dataset, {
      updateTabItems(global_session, "tabs", "dataset")
    })
    observeEvent(input$go_to_maps, {
      updateTabItems(global_session, "tabs", "maps")
    })
    observeEvent(input$go_to_timeline, {
      updateTabItems(global_session, "tabs", "timeline")
    })
  })
}
