library(shiny)

fluidPage(
    titlePanel("US gas price difference"),
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
)
