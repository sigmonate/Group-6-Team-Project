library(shiny)
library(tidyverse)
library(ggplot2)

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
        
        gas.data <- read.csv('../data/gas.data.reformatted.csv')
        
        max.gas.prices <- gas.data %>% 
            select(Date, City, Gas.Prices..dollars.per.gallon.) %>% 
            group_by(City) %>% 
            filter(Gas.Prices..dollars.per.gallon. == max(Gas.Prices..dollars.per.gallon., na.rm = TRUE))
        
    })

    output$gasminTable <- renderTable({
        
        gas.data <- read.csv('../data/gas.data.reformatted.csv')
        
        min.gas.prices <- gas.data %>% 
            select(Date, City, Gas.Prices..dollars.per.gallon.) %>% 
            group_by(City) %>% 
            filter(Gas.Prices..dollars.per.gallon. == min(Gas.Prices..dollars.per.gallon., na.rm = TRUE))
        
    })
    
    output$textOutput <- renderText({
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
}
)
