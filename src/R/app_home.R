# homepage for the app #


# packages
library(shinydashboard)

app_home <- tagList(
  tags$div(
    class = "home-title",
    tags$p("GBIF | Global Biodiversity Information Facility"),
    tags$h1("Free and open access to biodiversity data"),
  ),

  # buttons to navigate to other tabs
  actionButton(
    inputId = "dataset",
    label = menuSubItem(
      text = tags$span("Dataset", class = "button-text"),
      icon = icon("database", class = "icon"),
      tabName = "dataset"
    ),
    class = "button button-dataset"
  ),
  actionButton(
    inputId = "maps",
    label = menuSubItem(
      text = tags$span("Maps", class = "button-text"),
      icon = icon("map", class = "icon"),
      tabName = "maps"
    ),
    class = "button button-maps",

  ),
  actionButton(
    inputId = "about",
    label = menuSubItem(
      text = tags$span("About", class = "button-text"),
      icon = icon("info-circle", class = "icon"),
      tabName = "about"
    ),
    class = "button button-about"
  )
)