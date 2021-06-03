#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

data <- read.delim("US_GAS_GB_original_Data_Used.csv", sep = ',')
data2 <- select(data, - Date, -X, -X.1, -X.2)

Minimum <- sapply(data2,min, na.rm = TRUE)
Maximum <- sapply(data2,max, na.rm = TRUE)
Diffrence <- Maximum - Minimum
min_frame <- as.data.frame(Minimum)
max_frame <- as.data.frame(Maximum)
Dif_frame <- as.data.frame(Diffrence)

main_set <-bind_cols(min_frame, max_frame, Dif_frame)


shinyServer(function(input, output) {
  sample2 <- reactive({
    main_set
  })

    output$GasData <- renderTable({
      cityFilter <- main_set[input$city,] 
      
    })
    

})





