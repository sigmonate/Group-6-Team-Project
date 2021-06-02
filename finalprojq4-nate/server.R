#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        
        data <- read.csv('GAS-DATA-AS-CSV.csv.bz2')
        data2 <- data %>% 
            pivot_longer(
                contains("x"),
                names_to = "date",
                values_to = "price",
                names_repair = "unique"
            ) %>% 
            mutate(date = substr(date, 2, 10))
        data3 <- data2 %>% 
            pivot_wider(date,
                        names_from = "City",
                        values_from = "price") %>%
            select(-date)
        
        #data3$Seattle <- unlist(data3$Seattle)
        #data3$Boston <- unlist(data3$Boston)
        #data3$Chicago <- unlist(data3$Chicago)
        #data3$Denver <- unlist(data3$Denver)
        #data3$Cleveland <- unlist(data3$Cleveland)
        #data3$Houston <- unlist(data3$Houston)
        #data3$NewYork <- unlist(data3$NewYork)
        #data3$LosAngeles <- unlist(data3$LosAngeles)
        #data3$SanFrancisco <- unlist(data3$SanFrancisco)
        #data3$Miami <- unlist(data3$Miami)
        
        #as.integer(data3$Seattle)
        #as.integer(data3$Boston)
        #as.integer(data3$Chicago)
        #as.integer(data3$Cleveland)
        #as.integer(data3$Denver)
        #as.integer(data3$LosAngeles)
        #as.integer(data3$Miami)
        #as.integer(data3$NewYork)
        #as.integer(data3$Houston)
        #as.integer(data3$SanFrancisco)
        
        
        x <- input$Cityone
        y<- input$Citytwo
        
        ggplot(data3)+
            geom_point(aes_string(x, y), col = "blue")
       

    }

)
}
)

