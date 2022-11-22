## Setup
#options(repos = c(REPO_NAME = "https://colorado.rstudio.com/rspm/all/__linux__/focal/latest"))
#options(repos = c(RSPM = "https://colorado.rstudio.com/rspm/all/__linux__/focal/latest", PPM = ""))
#options(repos = c(REPO_NAME = "https://packagemanager.posit.co/cran/latest"))

# options(repos = c(
#   CRAN_RSPM = "https://colorado.rstudio.com/rspm/all/__linux__/focal/latest",
#   #Internal = "https://aboriginal-pogona.staging.eval.rstudio.com/packages/internal/latest",
#   #binary = "https://packagemanager.rstudio.com/all/__linux__/focal/latest",
#   #source = "https://packagemanager.rstudio.com/all/latest",
#   CRAN = "https://cloud.r-project.org"
# ))

library(shiny)
library(usethis)
library(remotes)
library(renv) #renv::upgrade(version = "0.16.0")
#library(talkingheadr) #renv::install("dgruenew/talkingheadr")

# Private package from: https://rstudio.slack.com/archives/C04280LRVQT/p1667430400292769?thread_ts=1667422300.132889&cid=C04280LRVQT 
# https://github.com/dgruenew/talkingheadr

# Create a GitHub PAT via R with usethis::create_github_token() 
# Set it with gitcreds::gitcreds_set() and Sys.setenv(GITHUB_PAT = "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") 
# Store as env variable with usethis::edit_r_environ()
# Follow: https://carpentries.github.io/sandpaper-docs/github-pat.html 
# For package installation follow: https://rstudio.github.io/renv/reference/install.html?q=authentica#remotes-syntax 
# Test our pat with: remotes::install_github("r-lib/conflicted") 
# Install our private package: renv::install("dgruenew/talkingheadr")

# # define a function providing authentication
# options(renv.auth = function(package, record) {
#   if (package == "talkingheadr")
#     return(list(GITHUB_PAT = "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"))
# })


#options(renv.auth.talkingheadr = list(GITHUB_PAT = "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"))
#renv:::renv_remotes_resolve("github::dgruenew/talkingheadr")
#renv::install("dgruenew/talkingheadr")

## These are some challenging packages
#library(stringi)
#library(arrow)



server <- function(input, output) {
  
  #Check size of file with object.size()
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars_1648bytes" = cars,
           "cars_4848bytes" = rbind(cars,cars,cars,cars,cars),
           "cars_8848bytes" = rbind(cars,cars,cars,cars,cars,cars,cars,cars,cars,cars))
  })
  
  # Table of selected dataset ----
  output$table <- renderTable({
    datasetInput()
  })
  
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
}