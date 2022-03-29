library(shiny)
library(pdftools)
library(stringr)
library(xlsx)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
   observe({
     df <- data.frame(Sample_ID = " ", Technician_Name = " ", Date = " ", Time = " ", Results_Cov2 = " ", Results_FluA = " ", Results_FluB = " ", Results_RSV = " ")

    pdf_file2  <- input$fileInput2
    
    if(is.null(input$fileInput2))
    {
      return(NULL)
      
    }
    else
    {
      
      numfiles = nrow(input$fileInput2) 
      
      for (i in 1:numfiles){
        
        txt <- pdf_text(input$fileInput2[[i, 'datapath']])
        
        #cat(txt[1])
        
        #extract sample ID
        sampleID <- techName <- gsub('^.*Sample ID:\\s*|\\s*Run Date:.*$', '', txt)
        
        #print(sampleID)
          
        #extract name of machine operator
        techName <- gsub('^.*Operator:\\s*|\\s*Serial.*$', '', txt)
        
        techName
        
        #extract first intial
        techInitials1 <- substr(techName,1,1)
        
        techInitials1 
        
        #extract last name
        techInitials2 <- word(techName, 2, sep = ' ')
        
        #second initial
        techInitials2 <- substr(techInitials2,1,1)
        
        techInitials2
        
        #combine initlas
        techInitals <- paste(techInitials1, techInitials2)
        
        #remove space
        techInitials <- gsub(" ", "", techInitals , fixed =TRUE)
        
        #print(techInitials)
        
        #extract date of sample run
        date <- gsub('^.*Run Date:\\s*|\\s* Detected:.*$', '', txt)
        
        #remove newline
        date <- str_replace_all(date, "[\r\n]" , "")
        
        #remove time
        date <- gsub("^((\\w+\\W+){2}\\w+).*$","\\1",date)
        
        #print(date)
        
        #extract time and date
        time <- gsub('^.*Run Date:\\s*|\\s* Detected:.*$', '', txt)
        
        #remove date
        time2 <- sub('^\\w+\\s\\w+\\s\\w+\\s', '', time)
        
        #remove whitespace
        time3 <- gsub(" ", "", time2, fixed = TRUE)
        
        time3 <- sub("([0-9])([A-Z])", "\\1 \\2", time3)
        
        #print(time3)
        
        #take test results
        detected <- gsub('^.*Viruses\\s*|\\s*Run Details.*$', '', txt)
        
        #remove whitespace
        detected <- gsub(" ", "", detected, fixed = TRUE)
        
        detected
        
        print(detected)

        #print(detected)
        
        #check if covid positive
        positive <- "NotDetectedSevereAcuteRespiratorySyndromeCoronavirus2(SARS-CoV-2)"
        
        positiveFluA <- "NotDetectedInfluenzaA"
        
        positiveFluB <- "NotDetectedInfluenzaB"
        
        positiveRSV <- "NotDetectedRespiratorySyncytialVirus"
        
        #check if covid positive results in test
        checkPositive <- grepl(positive, detected, fixed = TRUE)
        
        print("Cov")
        
        print(checkPositive)
        
        checkPositiveFluA <- grepl(positiveFluA, detected, fixed = TRUE)
        
        print("FluA")
        
        print(checkPositiveFluA)
        
        checkPositiveFluB <- grepl(positiveFluB, detected, fixed = TRUE)
        
        print("FluB")
        
        print(checkPositiveFluB)
        
        checkPositiveRSV <- grepl(positiveRSV, detected, fixed = TRUE)
        
        print("RSV")
        
        print(checkPositiveRSV)
        
        #print if results are positive or not
        if (checkPositive == TRUE) {
          
          CovCheck <- "Not Detected"
          
        } else {
          
          CovCheck <- "Detected"
          
        }
        
        if (checkPositiveFluA == TRUE) {
          
          FluACheck <- "Not Detected"
          
        } else {
          
          FluACheck <- "Detected"
          
        }
        
        
        if (checkPositiveFluB == TRUE) {
          
          FluBCheck <- "Not Detected"
          
        } else {
          
          FluBCheck <- "Detected"
          
        }
        
        if (checkPositiveRSV == TRUE) {
          
          RSVCheck <- "Not Detected"
          
        } else {
          
          RSVCheck <- "Detected"
          
        }
        
        df[nrow(df) + 1,] = c(sampleID, techInitials, date, time3, CovCheck, FluACheck, FluBCheck, RSVCheck)
        
      }
      
      
      
      print(df)
      
      # output$downloadData <- downloadHandler(
      #   filename = function() {
      #     paste(' BiofireDataPDFExtracted.csv', sep='')
      #   },
      #   content = function(file) {
      #     write.csv(df, file, row.names = FALSE)
      #   }
      # )
      
        output$downloadData<- downloadHandler(
          filename = function() { "name.xlsx" },

          content = function(file) {
            tempFile <- tempfile(fileext = ".xlsx")
            write.xlsx(df, tempFile)
            file.rename(tempFile, file)
          })
      
    }
  })
})


