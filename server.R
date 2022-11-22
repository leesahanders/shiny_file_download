## Setup
#options(repos = c(REPO_NAME = "https://colorado.rstudio.com/rspm/all/__linux__/focal/latest"))
library(shiny)
library(usethis)
library(renv)
#library(talkingheadr) #renv::install("dgruenew/talkingheadr")
# Private package from: https://rstudio.slack.com/archives/C04280LRVQT/p1667430400292769?thread_ts=1667422300.132889&cid=C04280LRVQT 
# https://github.com/dgruenew/talkingheadr

## These are some challenging packages
#library(stringi)
#library(arrow)

# # define a function providing authentication
# options(renv.auth = function(package, record) {
#   if (package == "talkingheadr")
#     return(list(GITHUB_PAT = "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"))
# })

# gitcreds::gitcreds_set()

# Create a GitHub PAT via R with usethis::create_github_token() 
# Store as env variable with usethis::edit_r_environ()
# Follow: https://carpentries.github.io/sandpaper-docs/github-pat.html 
# For package installation follow: https://rstudio.github.io/renv/reference/install.html?q=authentica#remotes-syntax 

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