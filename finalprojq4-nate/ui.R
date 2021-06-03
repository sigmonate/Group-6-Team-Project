library(shiny)



shinyUI(navbarPage("Gas Prices in US Cities",
    tabPanel("Introduction"),
    tabPanel("City vs City Gas Price Relationship Over Time",
        # Sidebar with a slider input for number of bins
        sidebarLayout(
            sidebarPanel(
                selectInput("Cityone", label = h3("City One"),
                            choices = list("Boston" = 'Boston', "Chicago" = 'Chicago',
                                            "Cleveland" = 'Cleveland', "Denver" = 'Denver',
                                            "Houston" = 'Houston', "Los Angeles" = 'LosAngeles',
                                            "Miami" = 'Miami', "New York" = 'NewYork',
                                            "San Francisco" = 'SanFrancisco', "Seattle" = 'Seattle'),
                            selected = "Seattle"),
                selectInput("Citytwo", label = h3("City Two"),
                            choices = list("Boston" = 'Boston', "Chicago" = 'Chicago',
                                            "Cleveland" = 'Cleveland', "Denver" = 'Denver',
                                            "Houston" = 'Houston', "Los Angeles" = 'LosAngeles',
                                            "Miami" = 'Miami', "New York" = 'NewYork',
                                            "San Francisco" = 'SanFrancisco', "Seattle" = 'Seattle'),
                            selected = "Boston"),
            
            ),
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("distPlot"),
                textOutput("textOutput")
            )
        )
    ),
    tabPanel("Differences in US City Gas Prices",
        sidebarLayout(
            sidebarPanel(
                #checkboxInput("checkbox", label = "Choice A", value = TRUE),
                selectInput("city", "Select a city", choices = list("Boston" = 'Boston..MA.', "Chicago" = 'Chicago..IL', "Cleveland" = 'Cleveland..OH.', 
                                                                    "Denver" = 'Denver..CO', "Houston" = 'Houston..TX', 
                                                                    "Los Angeles" = 'Los.Angeles..CA', "Miami" = 'Miami..FL.',
                                                                    "New York" = 'New.York..NY', "San Francisco" = 'San.Francisco..CA', 
                                                                    "Seattle" = 'Seattle..WA.'), selected = 'Boston..MA.')
                ),
            mainPanel(
                tableOutput("GasData")
            )
        )
    ),
    tabPanel("Conclusion",
        tableOutput("gasmaxTable"),
        tableOutput("gasminTable"),
    )
))
