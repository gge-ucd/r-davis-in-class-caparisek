# homework for week 8 - 04March2019

# Part 1 ------------------------------------------------------------------


# Download a new American River data set using this piece of code
library(tidyverse)
library(lubridate)
am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)
        #should have a data frame with 35,038 obs of 5 variables




# 1) Make a datetime column by using paste to combine the date and time columns; remember to convert it to a datetime!
am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "") #Combine date and time columns
    #refer to variables by name in a data frame by ($)
glimpse(am_riv) #Check datetime data type, shows up as character
am_riv$datetime <- ymd_hms(am_riv$datetime)  #Lubridate function to convert datetime data type to dttm

# 2) Calculate the weekly mean, max, and min water temperatures and plot as a point plot (all on the same graph)

weekly_water_tmp<-am_riv%>%
  group_by(week=week(datetime))%>%
  summarise(weekly_avg=mean(Temperature),weekly_max=max(Temperature),weekly_min=min(Temperature))
str(weekly_water_tmp)
glimpse(weekly_water_tmp)

weekly_water_tmp %>% 
  ggplot(aes(x=week))+
  geom_point(aes(y=weekly_min),color="skyblue")+
  geom_point(aes(y=weekly_max),color="red")+
  geom_point(aes(y=weekly_avg),color="springgreen4")+ 
  xlab("Week")+ ylab("Temperature")+
  theme_bw()


# 3) Calculate the hourly mean Level for April through June and make a line plot (y axis should be the hourly mean level, x axis should be datetime)

hourly_level<-am_riv%>%
  filter(month(datetime)>3)%>%
  filter(month(datetime)<7)%>%
  group_by(Date,hour=hour(datetime))%>%
  summarise(hourly_mean_level=mean(Level))
hourly_level$date_hour<-paste(hourly_level$Date," ",hourly_level$hour,sep="")
hourly_level$date_hour<-ymd_h(hourly_level$date_hour)

ggplot(data=hourly_level, aes(x=date_hour,y=hourly_mean_level))+
  geom_line(color="purple")





# Part 2 ------------------------------------------------------------------

#Use the mloa_2001 data set (if you don’t have it, download the .rda file from the resources tab on the website). 
load("data/mauna_loa_met_2001_minute.rda")

#create a datetime column (we did this in class).
mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)
glimpse(mloa_2001)

#Convert to datetime format
mloa_2001$datetime<- ymd_hm(mloa_2001$datetime) 

#Remove the NAs (-99 and -999) 
mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)

#Then, write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column (so if your data set does not already have a datetime column, you’ll need to create one!)

# https://gge-ucd.github.io/R-DAVIS/lesson_functions.html

plot_temp <- function(monthinput, dat = mloa2){   #monthinput doesn't exist yet 
  df <- filter(dat, month == monthinput)
  plot <- df %>% 
    ggplot()+ geom_line(aes(x=datetime, y = temp_C_2m), color = "purple")+
    theme_bw()
  return(plot)
}

plot_temp(4) #Testing: try to plot of April temps 











