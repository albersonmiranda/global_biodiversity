# run app #


# templates
source("R/ui.R")
source("R/server.R")

# Specify the application port
options(shiny.host = "0.0.0.0")
options(shiny.port = 8180)

# run app
shiny::shinyApp(ui = app_ui, server = app_server)
