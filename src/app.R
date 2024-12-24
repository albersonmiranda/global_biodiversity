# run app #


# templates
source("R/ui.R")
source("R/server.R")

# Specify the application port
port <- as.numeric(Sys.getenv("PORT", "3838"))
options(shiny.host = "0.0.0.0")
options(shiny.port = port)

# run app
shiny::shinyApp(ui = app_ui, server = app_server)
