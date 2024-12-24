# X Company Home Assignment

## A brief description of the project and my process
This is my approach for the 2nd recruitment stage for X Company. This project provides [an interactive platform to explore biodiversity data from the GBIF](https://globalbiodiversity-542496339289.southamerica-east1.run.app). Users can view datasets, maps, and timelines of species observations.

## My Process
I started by exploring the data and understanding its structure. From the very beginning, I was interested in displaying images of the species, as I was curious about what those names looked like. So, I spent my first minutes identifying foreign keys and testing whether the images were available and matched the descriptions (I checked with *Canis lupus* and ladybugs!).

Next, I handled the data. I could have easily used a simple CSV for the Poland dataset, but I knew I could do more. I considered using Parquet and Feather formats but decided on `duckdb`. I’m not experienced in shipping apps; in my experience, I usually work with on-premises or cloud databases. I’m not sure how much technical debt shipping a database with the app incurs, so in a real-life scenario, I’d consult someone more experienced.

I dropped all unused columns to create a lightweight database. I then tested the app's performance with the global dataset, and it performed well with 20 GB of data. However, GitHub has a 2 GB limit, so I decided to focus on Europe. Besides, I've already reached my quota on Github LFS 💸.

For the project structure, I aimed for clarity and organization. The `data-raw` folder contains scripts for downloading and processing data, `data` contains the processed data, `R` contains the modules and server, and `www` holds images and CSS. I considered breaking `style.css` into smaller files (like `buttons.css`), but I think it’s fine for now.

For the UI, I chose to use `{shinydashboard}` and reused a lot of code and styling from my previous apps. Realistically, three days while working full-time and pursuing a doctorate is a short time to develop a full-fledged app. Stack Overflow and ChatGPT were my usual allies in this journey. What I didn’t expect was the rich blog material from X Company, which was incredibly helpful. Nearly everything I needed was covered in some level of detail on your blog.

For the first module, I focused on the dataset module, which wasn’t a requirement but I think is a basic feature. Then, I realized I missed having a homepage. It’s not common in Shiny apps, but I like it because it gives a sense of completeness and professionalism to the app. I chose Poland's wildlife symbols as background images for the module buttons. I think the transparency hover effect was a nice touch—hope you like it!

Once the logic for querying the database was established in the dataset module, implementing the map functionality wasn’t much additional effort, especially since I had worked with `{leaflet}` before and found plenty of resources online, including examples very close to this assignment. I also added a checkbox to filter observations with images, which I found very appealing (I’ve enjoyed exploring the images on the map!).

For the timeline module, I initially considered defaulting to all countries to display more data and a prettier plot (as there are usually few observations for a specific species in a single country), but I didn’t think that would be smart performance-wise. I have a lot of experience with `{plotly}`, so that part was straightforward.

Finally, when everything else was done, I used the "featured projects" section from the GBIF website to populate the homepage. This helps demonstrate the potential benefits of a homepage in communicating other projects while making the app more beautiful and engaging.

No dedicated JavaScript was needed for this project. Everything was already covered by the R ecosystem.

I’m not experienced in debugging Shiny apps, so I relied heavily on the console. This was also my first time using unit tests for a Shiny app. I’ve used `{testthat}` before, but only for R packages. The tests consisted of navigating through the app and recording snapshots with `{shinytest2}`.

For deployment, I used Google Cloud Run. I’m currently working on Google’s Professional Cloud Security Engineer certification, so I’m familiar with the platform. I also have experience with containerization and Docker, so the process was smooth. I would typically integrate the deployment process with the GitHub repository and use a CI/CD pipeline, but the database size posed a problem. Using `git-lfs` would require changes to the Dockerfile, and I didn’t want to risk it.

That’s it! I hope you enjoy the app, and I’m looking forward to your feedback! I’ve learned a lot during this process, and I’m confident this experience will be valuable in my future projects.

## Thanks
Special thanks to my fiancée for testing the app. Before asking for her help, I thought it was complete (it wasn’t).

## Author
Alberson Miranda
