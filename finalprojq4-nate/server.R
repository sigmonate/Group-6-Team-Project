library(shiny)
library(tidyverse)
library(ggplot2)

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

        
        x <- input$Cityone
        y<- input$Citytwo
        
        ggplot(data3,aes_string(x, y))+
            geom_point(col = "blue")+
            xlab(paste("Price in", input$Cityone))+
            ylab(paste("Price in", input$Citytwo))+
            geom_smooth(col = "red", se = FALSE)
           
       

    }
    

)
    output$textOutput <- renderText({
        paste("This chart was designed to answer the question: 'Do the gas prices in
        American cities fluctutate independently or together?' To answer this question,
        the chart compares the prices of two chosen cities from the dataset. Each point
        represents a month from June of 2000 to April of 2021. If the cities were fluctuating
        independently, the points would be scattered across the chart.
        Meanwhile, if the cities were fluctuating together, the points should
        form a roughly linear trend. As you can see, every comparison between two
        cities is roughly linear. In some cases the correlation is incredibly strong.
        This chart thus lends support to an answer to our question: the cities
        fluctuate together, not independently.")
    })
}
)

