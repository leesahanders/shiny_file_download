library(stringi)
library(arrow)


#options(repos = c(REPO_NAME = "https://colorado.rstudio.com/rspm/all/__linux__/focal/latest"))



server <- function(input, output) {
  
  # Reactive value for selected dataset ----
  # datasetInput <- reactive({
  #   switch(input$dataset,
  #          "rock" = rock,
  #          "pressure" = pressure,
  #          "cars" = cars)
  # })
  
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