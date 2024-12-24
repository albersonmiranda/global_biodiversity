app_about_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    titlePanel("X Company Home Assignment"),
    fluidRow(
      column(
        12,
        tags$div(
          class = "about-section",
          tags$h2("A brief description of the project and my process"),
          tags$p("This is my approach for the 2nd recruitment stage for X Company. This project provides an interactive platform to explore biodiversity data from the GBIF. Users can view datasets, maps, and timelines of species observations."),
          tags$h3("My Process"),
          tags$p("I started by exploring the data and understanding its structure. Since the very beginning, I was interested in displaying images of the species, since I've became curious about what that names look like. So I've spent my first minutes identifying foreign keys and testing if the images were available and matches the description (I checked with Canis lupus and ladybugs!)."),
          tags$p("Then data handling. I could easily use a simple csv for just Poland dataset, but I new that I could do more. I thought about parquet and feather, but I've decided to use duckdb. I'm not experienced in shipping apps. In my experience, I usually have a on premises or cloud database to work with. I don't know how much of a technical debt shipping a db with the app is, so, in real life, I'd ask for help to somebody more experienced."),
          tags$p("I've drop all unused columns to archieve a lightweight db. Then tested the performance of the app with the whole world dataset and it was pretty good for 20gb of data. But Github has a 2gb limit, so I've decided to stick with Europe."),
          tags$p("My choice for the project structure was based on what I think would be more clear and organized. `data-raw` has the scripts to download and process the data, `data` has the processed data, `R` has the modules and the server and `www` has the images and the css. Maybe I should break style.css into smaller files (like buttons.css), but I think it's fine for now."),
          tags$p("For the UI, my choice was to use {shinydashboard} and reuse a lot of the code and styling from my previous apps. Being realistic, 3 days while working full-time and coursing a doctorate is a short time to develop a full-fledged app. Stackoverflow and chatGPT were the usual allies in this journey. What I wasn't expecting was the rich blog material from X Company, which helped me a lot in the process. Basically, almost everything I've needed was covered in some level of detail in your blog."),
          tags$p("For the first module, I went to the dataset module, which wasn't a requirement but I think it's a basic feature. Then I missed a homepage. I don't think it's usual in shiny apps, but I like it and it gives a sense of completeness and professionalism to the app. I've chosen Poland wildlife symbols to show as the modules buttons background images. I think that the transparency hover trick was a nice touch, hope you liked it!"),
          tags$p("Once the logic for querying from the DB was estabilished in the dataset module, the map bit wasn't much more effort, especially because I've worked with {leaflet} before and there was a lot of material on the internet, including something very close to this assignment. I've also added a check button to filter only the observations with images, which is very appealing to me (I'm really enjoying exploring images in the map!)."),
          tags$p("For the timeline module, I initially thought about defaulting to all countries to display more data and a prettier plot (there are usually few observations for a specific species in a single country), but I don't think that'd be smart performance-wise. I've worked a lot with {plotly} before, so that bit was trivial."),
          tags$p("Finally, when everything was done, I've robbed the 'featured projects' session from the GBIF website to populate the homepage. It helps to show the potential benefits for a homepage to communicate other projects and making the app more beautiful and engaging."),
          tags$p("No dedicated Javascript was needed for this project. Everything was already covered by the R ecosystem."),
          tags$p("I'm not experienced in debugging shiny apps, so I've depended a lot on the console. That was my first time using unit tests for a shiny app. I've used {testthat} before, but only for R packages. The tests consisted on navigating through the app and recording snapshots with {shinytest2}."),
          tags$p("Finally, for deploying I used Google Cloud Run. I'm currently going through Google's Professional Cloud Security Engineer certification, so I'm familiar with the platform. I'm experienced in containerization and I've used Docker before, so it was a smooth process. I'd usually integrate the deployment process with the Github repository and use a CI/CD pipeline, but the db size was a problem. Using git-lfs would require a few changes in the Dockerfile and I didn't want to risk it."),
          tags$p("That's it! I hope you enjoy the app and I'm looking forward to your feedback! I've learned a lot in this process and I'm cerain that all of this will be useful in my future projects."),
          tags$h3("Thanks"),
          tags$p("Special thanks to my fiancee for testing the app. Before asking her help I thought it was complete (it wasn't)."),
          tags$h3("Author"),
          tags$p("Alberson Miranda")
        )
      )
    )
  )
}
