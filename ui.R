#https://shiny.rstudio.com/articles/download.html
#add some text

ui <- fluidPage(
  
  # App title ----
  titlePanel("Downloading Data"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Choose dataset ----
      selectInput("dataset", "Choose a dataset:",
                  choices = c("rock", "pressure", 
                              "cars_1648bytes", "cars_4848bytes", "cars_8848bytes")),
      

      
      # Button
      downloadButton("downloadData", "Download")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      tableOutput("table")
      
    )
    
  )
)