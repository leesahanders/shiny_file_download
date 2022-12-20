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
#library(conflicted) #remotes::install_github("r-lib/conflicted") 
#library(talkingheadr) #renv::install("dgruenew/talkingheadr")

# reference: https://community.rstudio.com/t/setting-github-pat-for-rsconnect/127444 and https://docs.posit.co/connect/admin/r/package-management/#from-private-git-repositories 
# Private package from: https://github.com/dgruenew/talkingheadr, https://rstudio.slack.com/archives/C04280LRVQT/p1667430400292769?thread_ts=1667422300.132889&cid=C04280LRVQT 
# Create a GitHub PAT via R with usethis::create_github_token() 
# Set it with gitcreds::gitcreds_set() and Sys.setenv(GITHUB_PAT = "") 
# Store as env variable with usethis::edit_r_environ()
# Follow: https://carpentries.github.io/sandpaper-docs/github-pat.html 
# For package installation follow: https://rstudio.github.io/renv/reference/install.html?q=authentica#remotes-syntax 
# Test our pat with: remotes::install_github("r-lib/conflicted") 
# Install our private package: renv::install("dgruenew/talkingheadr")
# For publishing to Connect: Try setting the option packrat.authenticated.downloads.use.renv to TRUE, or installing the httr package.

#options(packrat.authenticated.downloads.use.renv = TRUE)
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