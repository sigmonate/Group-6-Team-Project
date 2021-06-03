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
        strong. This chart thus lends support to an answer to our question: the
        cities fluctuate together, not independently.")
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
    
    output$thirdTextOutput <- renderText({
        paste("In the following tables, we can see the differences between gas prices in different cities. With these tables, we can 
              compare each city to see the difference between the lowest and highest price, and to see all the lowest and
              highest points as well. From these tables, we can conclude that Los Angeles has the highest difference between 
              the lowest and highest gas price values standing at a 3.47$ difference. It is also important to notice that 
              San Francisco is following close behind at 3.21$. When considering the data of the lowest prices recorded 
              per city, it is important to take into consideration that Boston, Cleveland, Miami and Seattle only started
              recording their data into this data set from June 2003, while Chicago, Denver, Houston, Los Angeles, New York
              and San Francisco started recording their data from June 2000. We can see that most cites have their highest 
              value recorded in July 2008, probably due to the 2008 financial crisis (see the following for more reference: 
              https://www.investopedia.com/ask/answers/052715/how-did-financial-crisis-affect-oil-and-gas-sector.asp). 
              Miami and Chicago are anomalies in this context, with their highest values being recorded in a 
              different year (2017 and 2011, respectively).")
    }) 
    
    output$introTextOutput <- renderText({
        paste("In this app, you will be able to review the data of average gas prices in main cities in the US. The main dataset our 
              app utilizes is from the US Energy Information Administration. See the link if needed: 
              https://www.eia.gov/dnav/pet/pet_pri_gnd_a_epm0_pte_dpgal_m.htm. Our target audience is consumers of driving age 
              located in urban areas in the US. Using our app, you will be able to see how gas prices have changed in 
              urban areas in the US over time, when each city's gas prices were at their highest and lowest prices, which cities 
              have experienced the highest rates of increases in gas prices, and whether cities' gas prices usually fluctuate
              together or independently. The main libraries we used to make this app were shiny, tidyverse and ggplot2.")
    }) 
    
    output$concTextOutput <- renderText({
        paste("From the information collected in our app, we can conclude some very important information. We can see
              that most cities in the US have a fairly linear increase in gas prices over the years, and that the 2008
              financial crisis had a very big effect on gas prices.")
    }) 
    
}
)