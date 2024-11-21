library(shinydashboard)

# Modules
source("R/app_home.R")
source("R/app_dataset.R")
source("R/app_map.R")
source("R/app_timeline.R")

# UI
app_ui <- dashboardPage(
  title = "GBIF Data Explorer",
  dashboardHeader(
    title = tags$a(
      href = "https://www.gbif.org/",
      tags$img(
        src = "assets/img/full_logo_white.svg",
        class = "logo"
      )
    )
  ),
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Dataset", tabName = "dataset", icon = icon("database")),
      menuItem("Maps", tabName = "maps", icon = icon("map")),
      menuItem("Timeline", tabName = "timeline", icon = icon("chart-line")),
      menuItem("About", tabName = "about", icon = icon("info"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "styles/style.css"
      ),
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "styles/fonts.css"
      )
    ),
    tabItems(
      tabItem(tabName = "home", app_home_ui("home")),
      tabItem(tabName = "dataset", app_dataset_ui("dataset")),
      tabItem(tabName = "maps", app_map_ui("maps")),
      tabItem(tabName = "timeline", app_timeline_ui("timeline")),
      tabItem(tabName = "about", "Explore GBIF data with plots")
    )
  )
)
