library(shiny)
library(tidyverse)
library(ggplot2)
library(tidyr)

#data <- read.csv('../GAS-DATA-AS-CSV2')


shinyServer(function(input, output) {

    output$distPlot <- renderPlot({
        
        data <- read.csv('../GAS-DATA-AS-CSV2.csv')
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
            separate(date, c("month", "year")) %>%
            filter(year == input$date) %>%
            select(input$Cityone, month) 
        
        data3$month = factor(data3$month, levels = month.abb)

        y <- input$Cityone
        if (input$Cityone == "Chicago") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Chicago))
        } else if (input$Cityone == "Seattle") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Seattle)) +
                geom_line(mapping = aes(x = as.numeric(month), Seattle), color="red")
        } else if (input$Cityone == "Boston") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Boston))
        } else if (input$Cityone == "Denver") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Denver))
        } else if (input$Cityone == "Cleveland") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Cleveland))
        } else if (input$Cityone == "Houston") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Houston))
        } else if (input$Cityone == "LosAngeles") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, LosAngeles))
        } else if (input$Cityone == "Miami") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Miami))
        } else if (input$Cityone == "NewYork") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, NewYork))
        } else if (input$Cityone == "SanFrancisco") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, SanFrancisco))
        } 
        
        #x <- input$date
        
        #ggplot(data3) +
            #geom_point(mapping = aes(x = month, y))

    })
    
    output$textOutput <- renderText({
        paste("This chart was designed to answer the question: 'How gas prices have changed in urban areas in 
              the US over time?' To answer this a chart was created to display the monthly gas prices in a some
              of the major cities in the United States, starting in 2000. Each point represents the price of gas at
             that time as well as loctation. The y-axis displays the city, while the x-axis displays year (broken into
              months). This allows us to take a look into the trend of of gas prices in more densly populated areas.
            
            NOTE: Some locations did not collect data for the first few years. Chart will appear blank in those
              cases.")
    })

})
