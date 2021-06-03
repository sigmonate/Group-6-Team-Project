library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Monthly Gas Prices in Major U.S. Urban Areas"),

    # Sidebar with a slider input for number of bins
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
                                       "2019" = '19', "2020" = '20', "2021" = '21'), selected = "2000"
                                       ),),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            textOutput("textOutput")
        )
    )
))
