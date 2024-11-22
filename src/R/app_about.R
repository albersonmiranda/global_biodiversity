app_about_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    titlePanel("Appsilon Home Assignment"),
    fluidRow(
      column(
        12,
        tags$div(
          class = "about-section",
          tags$h2("A brief description of the project and my process"),
          tags$p("This is my approach for the 2nd recruitment stage for Appsilon. This project provides an interactive platform to explore biodiversity data from the GBIF. Users can view datasets, maps, and timelines of species observations."),
          tags$h3("Business Requirements"),
          tags$ul(
            tags$li("General overview:"),
            tags$ul(
              class = "checklist",
              tags$li("Build a dashboard that main purpose is to visualize selected species observations on the map and how often it is observed."),
              tags$li("Original dataset is large and covers the whole world. Please use only observations from Poland (see performance section).")
            ),
            tags$li("Specific Requirements:"),
            tags$ul(
              class = "checklist",
              tags$li("Users should be able to search for species by their vernacularName and scientificName. Search field should return matching names and after selecting one result, the app displays its observations on the map."),
              tags$li("Users should be able to view a visualization of a timeline when selected species were observed."),
              tags$li("Default view when no species is selected yet should make sense to the user. It shouldn’t be just an empty map and plot. Please decide what you will display.")
            ),
          ),
          tags$h3("Technical Requirements"),
          tags$ul(
            class = "checklist",
            tags$li("Don’t use any scaffolding tools like golem, packer, etc."),
            tags$li("Add readme that will help potential future developers of this app"),
            tags$li("Deploy the app to shinyapps.io (see infrastructure section)."),
            tags$li("Decompose independent functionalities into shinyModules."),
            tags$li("Add unit tests for the most important functions and cover edge cases."),
            tags$li("Share your solution using Github with @appsilon-hiring user. Do not open your repo to the public."),
          ),
          tags$h3("Extras"),
          tags$ul(
            tags$li("Beautiful UI skill:"),
            tags$ul(
              class = "checklist",
              tags$li("Use CSS and Sass to style your dashboard. Make the dashboard look better than standard Shiny."),
            ),
            tags$li("Performance optimization skill:"),
            tags$ul(
              class = "checklist",
              tags$li("Use as big dataset as you can (not only limited to Poland). Make sure your app initializes fast and the search field is fast. Use as many optimization techniques as possible and describe them in readme."),
            ),
            tags$li("Javascript skill:"),
            tags$ul(
              class = "checklist",
              tags$li("Use JavaScript to add some interactivity to your dashboard. For example, you can add a button that will change the color of the map."),
            ),
            tags$li("Infrasctructure skill:"),
            tags$ul(
              class = "checklist",
              tags$li("Instead of deploying the app to shinyapps.io, please deploy it to your own instance."),
            ),
          ),
          tags$h3("My Process"),
          tags$p("I started by exploring the data and understanding its structure. Since the very beginning, I was interested in displaying images of the species, since I've became curious about what that names look like. So I've spent my first minutes identifying foreign keys and testing if the images were available and matches the description (I checked with Canis lupus and ladybugs!)."),
          tags$p("Then data handling. I could easily use a simple csv for just Poland dataset, but I new that I could do more. I thought about parquet and feather, but I've decided to use duckdb. I'm not experienced in shipping apps. In my experience, I usually have a on premises or cloud database to work with. I don't know how much of a technical debt shipping a db with the app is, so, in real life, I'd ask for help to somebody more experienced."),
          tags$p("I've drop all unused columns to archieve a lightweight db. Then tested the performance of the app with the whole world dataset and it was pretty good for 20gb of data. But Github has a 2gb limit, so I've decided to stick with Europe."),
          tags$p("My choice for the project structure was based on what I think would be more clear and organized. `data-raw` has the scripts to download and process the data, `data` has the processed data, `R` has the modules and the server and `www` has the images and the css. Maybe I should break style.css into smaller files (like buttons.css), but I think it's fine for now."),
          tags$p("For the UI, my choice was to use {shinydashboard} and reuse a lot of the code and styling from my previous apps. Being realistic, 3 days while working full-time and coursing a doctorate is a short time to develop a full-fledged app. Stackoverflow and chatGPT were the usual allies in this journey. What I wasn't expecting was the rich blog material from Appsilon, which helped me a lot in the process. Basically, almost everything I've needed was covered in some level of detail in your blog."),
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
