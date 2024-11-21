# ui for the GBIF data explorer shiny app #


# packages
library(shinydashboard)

# modules
source("R/app_home.R")
source("R/app_dataset.R")

# ui
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
      tabItem(tabName = "home", app_home),
      tabItem(tabName = "dataset", app_dataset),
      tabItem(tabName = "maps", "Explore GBIF data on maps"),
      tabItem(tabName = "about", "Explore GBIF data with plots")
    )
  )
)
