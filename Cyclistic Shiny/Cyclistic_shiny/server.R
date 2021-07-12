library(librarian)
shelf(dplyr, ggplot2, plotly, leaflet, shiny)
set.seed(69)

mydata <- readRDS(file = "data.rds")

function(input, output, session) {


#### Plot Output ####
    
output$plot1 <- renderPlotly(
    
    if(input$variable_cont == "length"){
ggplotly(ggplot(mydata) +
            geom_histogram(aes(x=ride_length, fill = member_casual)) +
            xlim(0, 10000) +
            labs(fill = "Member Status?") +            
            xlab("Length of Time (s)") +
            ggtitle(paste("Distribution of","Length of Time (s)"," by Member Status")) +
            theme_bw())
    }
    else{
ggplotly(ggplot(mydata) +
            geom_histogram(aes(x=distance, fill = member_casual)) +
            xlim(0, 10000) +
            labs(fill = "Member Status?") +            
            xlab("Distance (m)") +
            ggtitle(paste("Distribution of ","Distance (m)","by Member Status")) +
            theme_bw())
    }           
)

output$plot2 <- renderPlotly(     
    
    if(input$variable_cat== "weekday"){
        
    ggplotly(ggplot(mydata) +
        geom_bar(aes(x=day, fill = member_casual), position = "dodge") +
        labs(fill = "Member Status?") +            
        xlab("Day of the Week") +
        ggtitle(paste("Distribution of","Weekday Usage"," by Member Status")) +
        theme_bw())
    }
    else{
        ggplotly(ggplot(mydata) +
            geom_bar(aes(x=rideable_type, fill = member_casual), position = "dodge") +
            labs(fill = "Member Status?") +            
            xlab("Rideable Type") +
            ggtitle(paste("Distribution of","Rideable Type"," by Member Status")) +
            theme_bw())
    }
)

#### Map Output ####
pal <- colorFactor(palette = c("red", "blue"), domain = mydata$member_casual)
output$mymap <- leaflet::renderLeaflet(
    mydata %>%
        sample_n(size = input$count) %>%
        leaflet() %>%
        addTiles() %>%
        addCircleMarkers(color = ~pal(member_casual),
                         clusterOptions = markerClusterOptions(maxClusterRadius = input$radius)) %>%
        addLegend(values = ~member_casual,
                  pal = pal,
                  opacity = 1,
                  title = "Member or Casual User?")
    
)
}