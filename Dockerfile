# Base R Shiny image
FROM rocker/shiny

# Make a directory in the container
RUN mkdir /home/shiny-app

# Install R dependencies
RUN install2.r --error --skipinstalled -n -1 \
        shinydashboard \
        shinycssloaders \
        shinyWidgets \
        duckdb \
        DT \
    && rm -rf /tmp/downloaded_packages

# Copy the src folder to the container
COPY src /home/shiny-app

# Expose the application port
EXPOSE 8180

# Run shiny::runApp() when the container launches
CMD ["R", "-e", "shiny::runApp('/home/shiny-app')"]
