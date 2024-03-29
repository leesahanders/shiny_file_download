## Setup
# options(repos = c(REPO_NAME = "https://colorado.rstudio.com/rspm/all/__linux__/focal/latest"))

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