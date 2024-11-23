# Base R Shiny image
FROM rocker/shiny

# Make a directory in the container
RUN mkdir /home/shiny-app

# install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgdal-dev \
    libproj-dev \
    xz-utils

# Install R dependencies
RUN install2.r --error --skipinstalled -n -1 \
        shinydashboard \
        shinycssloaders \
        shinyWidgets \
        duckdb \
        DT \
        leaflet \
        plotly \
    && rm -rf /tmp/downloaded_packages

# Copy the src folder to the container
COPY src /srv/shiny-server/

# set permissions
RUN chown -R shiny:shiny /srv/shiny-server

# Expose the application port
EXPOSE 3838

# Run
CMD ["/usr/bin/shiny-server"]
