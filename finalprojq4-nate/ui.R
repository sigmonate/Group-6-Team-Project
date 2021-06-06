library(shiny)



shinyUI(navbarPage("Gas Prices in US Cities",
    tabPanel("Introduction",
        textOutput("introTextOutput"),
        img(src = "gas.image.jpg", height = 425, width = 640)
    ),
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
                            selected = "Boston")
            ),
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("firstDistPlot"),
                textOutput("firstTextOutput")
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
                tableOutput("GasData"),
                tableOutput("gasmaxTable"),
                tableOutput("gasminTable"),
                textOutput("thirdTextOutput")
            )
        )
    ),
    tabPanel("Monthly Gas Prices in US Cities",
        sidebarLayout(
            sidebarPanel(
                selectInput("Cityone", label = "City",
                            choices = list("Boston" = 'Boston', "Chicago" = 'Chicago',
                                            "Cleveland" = 'Cleveland', "Denver" = 'Denver',
                                            "Houston" = 'Houston', "Los Angeles" = 'LosAngeles',
                                            "Miami" = 'Miami', "New York" = 'NewYork',
                                            "San Francisco" = 'SanFrancisco', "Seattle" = 'Seattle'),
                            selected = "Chicago"),
                selectInput("date", label = "Date",
                            choices = list("2000" = '00', "2001" = '01', "2002" = '02',
                                            "2003" = '03', "2004" = '04', "2005" = '05', "2006" = '06',
                                            "2007" = '07', "2008" = '08', "2009" = '09', "2010" = '10', 
                                            "2011" = '11', "2012" = '12', "2013" = '13', "2014" = '14',
                                            "2015" = '15', "2016" = '16', "2017" = '17', "2018" = '18',
                                            "2019" = '19', "2020" = '20', "2021" = '21'), selected = "2000")
            ),
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("secondDistPlot"),
                textOutput("secondTextOutput")
            )
        )
    ),
    tabPanel("Conclusion",
        textOutput("concTextOutput")
    )
))
