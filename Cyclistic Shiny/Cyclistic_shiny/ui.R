fluidPage(theme = shinythemes::shinytheme("yeti"),
    navbarPage(
        title = "Google's Cyclistic Data Shiny App",
        theme = shinythemes::shinytheme("yeti"),
        tabPanel("Documentation", 
                 sidebarPanel(
                    h2("Installation"),
                    p("Shiny is available on CRAN, so you can install it in the usual way from your R console:"),
                    code('install.packages("shiny")'),
                    br(),
                    br(),
                    br(),
                    br(),
                    tags$img(src="https://www.theswarmlab.com/img/portfolio/shiny.png", height = 225, width = 300),
                    br(),
                    "Shiny is a product of ", 
                    span("RStudio", style = "color:blue")
                ),
                mainPanel(
                    h1(strong("A Quick Run-Down"), align = "center"),
                    h3(strong("Instructions"), align = "center"),
                    p("This simple Shiny webpage was created as the final assignment for the", em('Creating Data Products'), 
                      "Coursera course. It contains two tabs: a plot tab and a map tab. These two tabs constitute a portion of the prveious two
                      assignments for this course. I simply edited those assignments' code to be used in a Shiny application easily. This was because I wasn't so much concerned
                      with the content of the tabs as I was in demonstrating basic Shiny skills."),
                    h4(strong("The  Assignment:")),
                    p("- Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application."),
                    p("- Deploy the application on Rstudio's shiny server."),
                    p("- Share the application link by pasting it into the provided text box."),
                    p("- Share your server.R and ui.R code on github."),
                    h4(strong("Requirements:")),
                    p("- Some form of input (widget: textbox, radio button, checkbox, ...)"),
                    p("- Some operation on the ui input in sever.R"),
                    p("- Some reactive output displayed as a result of server calculations"),
                    p("- You must also include enough documentation so that a novice user could use your application."),
                    br(),
                    h3(strong("Project Summary"), align = "center"),
                    p("This project uses the 'Cyclistic' data provided by google. The data describes a 12 month period during which a bike-shar company
                      named", em("Cyclistic"), "recorded each use of one of its bikes. Data collected includes where the bike was picked up and dropped off, including the time and date,
                      what type of bike was used, and whether the user was a member of their program or a casual user."),
                    p("The plots on the next tab vizualize some of these variables, colored-coded
                      by member status. The main idea is to compare the usage characteristics of members and non-members. You have two drop down menus to choose which graphs to display for a total of 4 graphs."),
                    p("The map on the last page simply the locations in Chicago where the bikes were first picked up (used), not where they were returned."),
                    p("It includes 2 inputs:"),
                    p("1. A filter for how many markers to be shown."),
                    p("2. A choice of how tightly the markers are clustered."))
                ),
        tabPanel("Plots",
                 sidebarPanel(
                     tags$h3("Which variable?"),
                     selectInput("variable_cont", "Choices (continuous):",
                                 choices = list("Ride Length (s)" = "length",
                                                "Ride Distance (m) " = "dist"
                                 )),
                     selectInput("variable_cat", "Choices (discrete):",
                                 choices = list("Day of the Week" = "weekday",
                                                "Type of Bike" = "type"
                                 ))
                 ), 
                 mainPanel(
                     plotly::plotlyOutput("plot1", width = "90%"),
                     plotly::plotlyOutput("plot2", width = "90%")
                 ) 
                 
        ), 
        tabPanel("Maps", 
                 sidebarPanel(
                     tags$h3("Options"),
                     sliderInput("count", "Number of Observations:",
                                 min = 0, max = 2000,
                                 value = 500),
                     sliderInput("radius", "Marker Cluster Radius:",
                                 min = 0, max = 200,
                                 value = 80)
                 ),
                 mainPanel(
                     leaflet::leafletOutput("mymap", height = 800)
        )
    ) 
)) 


