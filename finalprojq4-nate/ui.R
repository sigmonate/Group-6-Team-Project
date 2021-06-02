library(shiny)



shinyUI(navbarPage("Group 6 Project",
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
                tableOutput("gasmaxTable"),
                tableOutput("gasminTable"),
                textOutput("textOutput")
            )
        )
    )
))
