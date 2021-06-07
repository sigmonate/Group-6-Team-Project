library(shiny)
library(tidyverse)
library(ggplot2)
library(tidyr)

shinyServer(function(input, output) {
    
    
    output$introTextOutput <- renderText({
        paste("In this app, you will be able to review the data of average gas prices
        in main cities in the US. The main dataset our app utilizes is from the
        US Energy Information Administration. See the link if needed: https://www.eia.gov/dnav/pet/pet_pri_gnd_a_epm0_pte_dpgal_m.htm.
        Our target audience is consumers of driving age located in urban areas in
        the US. Using our app, you will be able to see how gas prices have changed
        in urban areas in the US over time, when each city's gas prices were at
        their highest and lowest prices, which cities have experienced the highest
        rates of increases in gas prices, and whether cities' gas prices usually
        fluctuate together or independently. The main libraries we used to make
        this app were shiny, tidyverse and ggplot2.")
})
    
    output$firstDistPlot <- renderPlot({
        
        
        data <- read.csv('Data-1.csv') %>% 
            select(-X, -X.1, -X.2, -Date)
        # data2 <- data %>% 
        #     pivot_longer(
        #         contains("x"),
        #         names_to = "date",
        #         values_to = "price",
        #         names_repair = "unique"
        #     ) %>% 
        #     mutate(date = substr(date, 2, 10))
        # data3 <- data2 %>% 
        #     pivot_wider(date,
        #                 names_from = "City",
        #                 values_from = "price") %>%
        #     select(-date)
        
        
        x <- input$Cityone
        y<- input$Citytwo
        
        
        ggplot(data,aes_string(x, y))+
            geom_point(col = "blue")+
            xlab(paste("Price in", input$Cityone))+
            ylab(paste("Price in", input$Citytwo))+
            geom_smooth(col = "red", se = FALSE)
        
        
    })
    
    output$gasmaxTable <- renderTable({
        
        gas.data <- read.csv('Data-2.csv')
        
        max.gas.prices <- gas.data %>% 
            select(Date, City, Gas.Prices..dollars.per.gallon.) %>% 
            group_by(City) %>% 
            filter(Gas.Prices..dollars.per.gallon. == max(Gas.Prices..dollars.per.gallon., na.rm = TRUE))
        
    })
    
    output$gasminTable <- renderTable({
        
        gas.data <- read.csv('Data-2.csv')
        
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
        strong. This chart thus lends support to an answer to our question: the
        cities fluctuate together, not independently.")
    })
    
    #data4 <- read.csv('Data-2.csv', sep = ',')
    #data5 <- data
    
    Minimum <- sapply(data,min, na.rm = TRUE)
    Maximum <- sapply(data,max, na.rm = TRUE)
    Difference <- Maximum - Minimum
    min_frame <- as.data.frame(Minimum)
    max_frame <- as.data.frame(Maximum)
    Dif_frame <- as.data.frame(Difference)
    
    main_set <-bind_cols(min_frame, max_frame, Dif_frame)
    
    
    sample2 <- reactive({
        main_set
    })
    
    output$GasData <- renderTable({
        cityFilter <- main_set[input$city,] 
        
    })
    
    output$secondDistPlot <- renderPlot({
        
        
        #manipulated data
        
        data2 <- read.csv('GAS-DATA-AS-CSV2.csv')
        data4 <- data2 %>% 
            pivot_longer(
                contains("x"),
                names_to = "date",
                values_to = "price",
                names_repair = "unique"
            ) %>% 
            mutate(date = substr(date, 2, 10))
        data3 <- data4 %>% 
            pivot_wider(date,
                        names_from = "City",
                        values_from = "price") %>%
            separate(date, c("month", "year")) %>%
            filter(year == input$date) %>%
            select(input$Cityone, month) 
        
        data3$month = factor(data3$month, levels = month.abb)
        
        y <- input$Cityone
        
        #static if/else. Wouldn't work any other way
        if (input$Cityone == "Chicago") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Chicago)) +
                geom_line(mapping = aes(x = as.numeric(month), Chicago), color="red")
        } else if (input$Cityone == "Seattle") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Seattle)) +
                geom_line(mapping = aes(x = as.numeric(month), Seattle), color="red")
        } else if (input$Cityone == "Boston") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Boston)) +
                geom_line(mapping = aes(x = as.numeric(month), Boston), color="red")
        } else if (input$Cityone == "Denver") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Denver)) +
                geom_line(mapping = aes(x = as.numeric(month), Denver), color="red")
        } else if (input$Cityone == "Cleveland") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Cleveland)) +
                geom_line(mapping = aes(x = as.numeric(month), Cleveland), color="red")
        } else if (input$Cityone == "Houston") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Houston)) +
                geom_line(mapping = aes(x = as.numeric(month), Houston), color="red")
        } else if (input$Cityone == "LosAngeles") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, LosAngeles)) +
                geom_line(mapping = aes(x = as.numeric(month), LosAngeles), color="red")
        } else if (input$Cityone == "Miami") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, Miami)) +
                geom_line(mapping = aes(x = as.numeric(month), Miami), color="red")
        } else if (input$Cityone == "NewYork") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, NewYork)) +
                geom_line(mapping = aes(x = as.numeric(month), NewYork), color="red")
        } else if (input$Cityone == "SanFrancisco") {
            ggplot(data3) +
                geom_point(mapping = aes(x = month, SanFrancisco)) +
                geom_line(mapping = aes(x = as.numeric(month), SanFrancisco), color="red")
        } 
        
        #x <- input$date
        
        #ggplot(data3) +
        #geom_point(mapping = aes(x = month, y))
        
    })
    
    output$secondTextOutput <- renderText({
        paste("This chart was designed to answer the question: 'How gas prices have changed in urban areas in 
              the US over time?' To answer this a chart was created to display the monthly gas prices in a some
              of the major cities in the United States, starting in 2001. Each point represents the price of gas at
             that time as well as loctation. The y-axis displays the city, while the x-axis displays year (broken into
              months). This allows us to take a look into the trend of of gas prices in more densly populated areas.
            
            NOTE: Some locations did not collect data for the first few years. Chart will appear blank in those
              cases.")
    })
    
    output$thirdTextOutput <- renderText({
        paste("In the following tables, we can see the differences between gas prices
        in different cities. With these tables, we can compare each city
        to see the difference between the lowest and highest price, and
        to see all the lowest and highest points as well. From these tables,
        we can conclude that Los Angeles has the highest difference between 
        the lowest and highest gas price values standing at a 3.47$ difference.
        It is also important to notice that San Francisco is following close
        behind at 3.21$. When considering the data of the lowest prices
        recorded per city, it is important to take into consideration that
        Boston, Cleveland, Miami and Seattle only started recording their
        data into this data set from June 2003, while Chicago, Denver, Houston,
        Los Angeles, New York and San Francisco started recording their
        data from June 2000. We can see that most cites have their highest 
        value recorded in July 2008, probably due to the 2008 financial
        crisis (see the following for more reference: https://www.investopedia.com/ask/answers/052715/how-did-financial-crisis-affect-oil-and-gas-sector.asp). 
        Miami and Chicago are anomalies in this context, with their highest
        values being recorded in a different year (2017 and 2011, respectively).
        ")
    }) 
    
    # output$introTextOutput <- renderText({
    #     paste("In this app, you will be able to review the data of average gas prices in main cities in the US. The main dataset our 
    #           app utilizes is from the US Energy Information Administration. See the link if needed: 
    #           https://www.eia.gov/dnav/pet/pet_pri_gnd_a_epm0_pte_dpgal_m.htm. Our target audience is consumers of driving age 
    #           located in urban areas in the US. Using our app, you will be able to see how gas prices have changed in 
    #           urban areas in the US over time, when each city's gas prices were at their highest and lowest prices, which cities 
    #           have experienced the highest rates of increases in gas prices, and whether cities' gas prices usually fluctuate
    #           together or independently. The main libraries we used to make this app were shiny, tidyverse and ggplot2.")
    # }) 
    
    output$concTextOutput <- renderText({
        paste("From the information collected in our app, we can conclude some very
        important information. We can see that most cities in the US have a fairly
        linear increase in gas prices over the years, and that the 2008 financial
        crisis resulted in gas prices rising substantially in many US urban areas.
        Included above are two tables, the first of which shows when the highest
        gas prices were recorded in each city, and the second showing when each
        city recorded their lowest gas prices. These tables both draw support to
        the conclusion made earlier that gas prices across American cities fluctuate
        together. For instance, it can be seen that six cities recorded their highest
        gas prices in July of 2008, while four cities recorded their lowest gas
        prices in December of 2001. Our group feels that we selected a very strong, reliable, and comprehensive
        dataset. Because the data recorded in this dataset was strictly numerical,
        and with its source being the US Energy Information Administration, we believe
        that our dataset provides relatively unbiased results. The numbers provided
        in the data averaged all prices for all grades of gasoline, so our group
        feels that the data couldn't have harmed or underrepresented other population
        groups of varying socioeconomic/financial status. We believe that it would
        be very worthwhile to continually update this project in the future. As
        time progresses, gas prices will continue to fluctuate and be tracked, which
        will allow for other researchers to explore these trends and draw new conclusions
        from these data.")
    }) 
    
}
)