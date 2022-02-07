library(shiny)
library(shinyWidgets)
library(shinycssloaders)
library(shinythemes)

shinyUI(fluidPage(

  fluidPage(
    theme = shinytheme("sandstone"),
    
    titlePanel("Biofire PDF Data Extractor"),
    
    navbarPage(
      "Extracts Data Needed From Biofire As A Excel File"
    ),
    
    mainPanel(

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
    
    column(
      width = 2,
      offset = 0,
      h6("Download Extracted Data"),
      style = 'padding-left:40px; padding-right:0px; padding-top: 25px; padding-bottom:0px',
      downloadButton('downloadData', 'Download')),
    
    )
    )
)
)
