librarian::shelf(dplyr, purrr, data.table, lubridate, ggplot2, plotly)

mydata <- do.call(rbind, lapply(list.files(pattern="*.csv"), fread))
summary(mydata)


mydata <- mydata %>% 
      select(-c(ride_id, start_station_name, end_station_name)) %>%
      mutate(ride_length = as.numeric(ended_at-started_at),
             ended_at = ymd_hms(ended_at),
             started_at = ymd_hms(started_at),
             day = factor(weekdays(started_at), c("Monday", "Tuesday", "Wednesday", "Thursday","Friday", "Saturday", "Sunday")),
             member_casual = as.factor(stringr::str_to_title(member_casual)))

mydata$ride_length <- replace(mydata$ride_length, which(mydata$ride_length < 0), NA)

ggplotly(
   ggplot(mydata) +
      geom_bar(aes(x=day, fill = member_casual), position = 'dodge')+
      labs(fill = "Casual User or Member?") +            
      xlab("Day of the Week") +
      ggtitle(("Frequencies of Weekday Usage by Member Status")) +
      theme_bw()
)

