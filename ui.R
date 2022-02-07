library(shiny)
library(shinyWidgets)
library(shinycssloaders)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  fluidPage(
    theme = shinytheme("sandstone"),
    
    titlePanel("Biofire PDF Data Extractor"),
        mainPanel(
            
        ),
    
    column(
      width = 2,
      offset = 0,
      style = 'padding-left:0px; padding-right:0px; padding-top:25px; padding-bottom:0px',
      h6("Choose a pdf file"),
      
      fileInput(
        inputId = "fileInput2",
        label =  NULL,
        multiple = TRUE,
        accept = NULL,
        width = NULL,
        buttonLabel = "Browse...",
        placeholder = "No file selected"
      )
      
      ),
    
    fluidRow(column(1,
                    downloadButton('downloadData', 'Download')),
    ))
    
))
