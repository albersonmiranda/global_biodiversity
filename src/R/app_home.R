app_home_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      class = "home-title",
      # two logos too close is kinda ugly, right? tags$img(src = "assets/img/gbif_logo.png", class = "logo"),
      tags$p("GBIF | Global Biodiversity Information Facility"),
      tags$h1("Free and open access to biodiversity data"),
      tags$h4("Explore the world's biodiversity data with our interactive tools and visualizations.")
    ),
    tags$div(
      class = "home-buttons",
      actionButton(ns("go_to_dataset"), "Go to Dataset", class = "button button-dataset", icon = icon("database")),
      actionButton(ns("go_to_maps"), "Go to Maps", class = "button button-maps", icon = icon("map")),
      actionButton(ns("go_to_timeline"), "Go to Timeline", class = "button button-timeline", icon = icon("chart-line"))
    ),

    # featured projects robbed from GBIF website :D
    tags$div(
      class = "featured-projects",
      tags$h2("Featured Projects"),
      tags$div(
        class = "projects-container",

        # card 1
        tags$div(
          class = "project-card",
          tags$a(
            href = "https://www.gbif.org/project/BIFA6_033/a-bilingual-open-source-checklist-and-digitization-of-taiwans-bee-fauna", # nolint
            tags$div(
              class = "project-card-image-area",
              tags$img(
                src = "assets/img/bee.jpg", # nolint
                class = "project-image"
              ),
            ),
            tags$div(
              class = "project-card-strip",
              tags$h4("A bilingual open-source checklist and digitization of Taiwan’s bee fauna"),
            )
          )
        ),
        # card 2
        tags$div(
          class = "project-card",
          tags$a(
            href = "https://www.gbif.org/project/BIFA6_029/small-animals-big-data-mobilizing-citizen-science-for-data-on-the-spiders-of-asia", # nolint
            tags$div(
              class = "project-card-image-area",
              tags$img(
                src = "assets/img/spidey.jpg",
                class = "project-image"
              ),
            ),
            tags$div(
              class = "project-card-strip",
              tags$h4("Small animals, big data: Mobilizing citizen science for data on the spiders of Asia"),
            )
          )
        ),
        # card 3
        tags$div(
          class = "project-card",
          tags$a(
            href = "https://www.gbif.org/project/BIFA6_030/using-microbial-metabarcoding-to-monitor-biodiversity-and-bioindicators-in-the-mekong-river", # nolint
            tags$div(
              class = "project-card-image-area",
              tags$img(
                src = "assets/img/whatever_is_this.jpg",
                class = "project-image"
              ),
            ),
            tags$div(
              class = "project-card-strip",
              tags$h4("Using microbial metabarcoding to monitor biodiversity and bioindicators in the Mekong River"),
            )
          )
        ),
        # card 4
        tags$div(
          class = "project-card",
          tags$a(
            href = "https://www.gbif.org/project/7gXiH4Eulp3oXAMmltDNPG/enriching-the-bhutan-biodiversity-portal-through-digitization-and-mobilization-of-specimen-collections", # nolint
            tags$div(
              class = "project-card-image-area",
              tags$img(
                src = "assets/img/monkey.jpg",
                class = "project-image"
              ),
            ),
            tags$div(
              class = "project-card-strip",
              tags$h4("Enriching the Bhutan Biodiversity Portal through digitization and mobilization of specimen collections"), # nolint
            )
          )
        )
      )
    )
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
