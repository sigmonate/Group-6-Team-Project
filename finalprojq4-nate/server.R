library(shiny)
library(tidyverse)
library(ggplot2)

shinyServer(function(input, output) {

    output$firstDistPlot <- renderPlot({

        
        data <- read.csv('GAS-DATA-AS-CSV2.csv')
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

        
        x <- input$Cityone
        y<- input$Citytwo
        
        
        ggplot(data3,aes_string(x, y))+
            geom_point(col = "blue")+
            xlab(paste("Price in", input$Cityone))+
            ylab(paste("Price in", input$Citytwo))+
            geom_smooth(col = "red", se = FALSE)
           
       
    })
    
    output$gasmaxTable <- renderTable({
        
        gas.data <- read.csv('gas.data.reformatted.csv')
        
        max.gas.prices <- gas.data %>% 
            select(Date, City, Gas.Prices..dollars.per.gallon.) %>% 
            group_by(City) %>% 
            filter(Gas.Prices..dollars.per.gallon. == max(Gas.Prices..dollars.per.gallon., na.rm = TRUE))
        
    })

    output$gasminTable <- renderTable({
        
        gas.data <- read.csv('gas.data.reformatted.csv')
        
        min.gas.prices <- gas.data %>% 
            select(Date, City, Gas.Prices..dollars.per.gallon.) %>% 
            group_by(City) %>% 
            filter(Gas.Prices..dollars.per.gallon. == min(Gas.Prices..dollars.per.gallon., na.rm = TRUE))
        
    })
    
    output$firstTextOutput <- renderText({
        paste("This chart was designed to answer the question: 'Do the gas prices
        in American cities fluctutate independently or together?' To answer this
        question, the chart compares the prices of two chosen cities from the dataset.
        Each point represents a month from June of 2000 to April of 2021. If the
        cities were fluctuating independently, the points would be scattered across
        the chart. Meanwhile, if the cities were fluctuating together, the points
        should form a roughly linear trend. As you can see, every comparison between
        two cities is roughly linear. In some cases the correlation is incredibly
        strong. This correlation can also be seen in the two tables displayed above,
        the first of which shows when the highest gas prices were recorded in each
        city, and the second showing when each city recorded their lowest gas prices.
        These tables both demonstrate that gas prices across American cities fluctuate
        together. For instance, it can be seen that six cities recorded their highest
        gas prices in July of 2008, while four cities recorded their lowest gas
        prices in December of 2001. These charts and tables thus lend support to
        an answer to our question: the cities fluctuate together, not independently.")
    })
    
    data <- read.delim("US_GAS_GB_original_Data_Used.csv", sep = ',')
    data2 <- select(data, - Date, -X, -X.1, -X.2)
    
    Minimum <- sapply(data2,min, na.rm = TRUE)
    Maximum <- sapply(data2,max, na.rm = TRUE)
    Diffrence <- Maximum - Minimum
    min_frame <- as.data.frame(Minimum)
    max_frame <- as.data.frame(Maximum)
    Dif_frame <- as.data.frame(Diffrence)
    
    main_set <-bind_cols(min_frame, max_frame, Dif_frame)
    
    
    sample2 <- reactive({
        main_set
    })
        
    output$GasData <- renderTable({
        cityFilter <- main_set[input$city,] 
    
    })

    output$secondDistPlot <- renderPlot({
        
        data <- read.csv('GAS-DATA-AS-CSV2.csv')
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
        
        y <- input$Cityone
        if (input$Cityone == "Chicago") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Chicago))
        } else if (input$Cityone == "Seattle") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Seattle))
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
    
    output$secondTextOutput <- renderText({
        paste("This chart was designed to answer the question: 'How gas prices have changed in urban areas in 
        the US over time?' To answer this a chart was created to display the monthly gas prices in a some
        of the major cities in the United States, starting in 2000. Each point represents the price of gas at
        that time as well as loctation. The y-axis displays the city, while the x-axis displays year (broken into
        months). This allows us to take a look into the trend of of gas prices in more densly populated areas.
            
        NOTE: Some locations did not collect data for the first few years. Chart will appear blank in those
        cases.")
    })    
    
}
)
