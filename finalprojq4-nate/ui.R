#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)



# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("City vs City price relationship"),

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
            plotOutput("distPlot")
        )
    )
))
