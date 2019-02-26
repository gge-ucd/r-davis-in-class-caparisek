#week 8 - class code 

#lecture tab: https://gge-ucd.github.io/R-DAVIS/lectures.html 
#1st course material tab: https://gge-ucd.github.io/R-DAVIS/lesson_lubridate.html 
#2nd (last 20 min) Iteration and Function.... https://gge-ucd.github.io/R-DAVIS/lesson_iteration.html


library(lubridate)
library(tidyverse)

load("data/mauna_loa_met_2001_minute.rda")
as.Date("02-01-1998", format = "%m-%d-%Y")
mdy("02-01-1998")

tm1 <- as.POSIXct("2016-07-24 23:55:22 PDT") #year month day hour minutes seconds (default)
tm1

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT") # timeszone 
tm3

#for specifying timezone and date format in the same call 
tm4<-as.POSIXct(strptime("2016/04/04 14:47", format = "%Y/%m/%d %H:%M"), tz= "America/Los_Angeles")

Sys.timezone() #tells you what timezone computer is defaulting in 

####

#do the same thing with lubridate - does the superfast/easy ... 

ymd_hm("2016/04/04 14:47", tz="America/Los_Angeles")

ymd_hms("2016-05-04 22:14:11", tz="GMT") #converts default timezone (LA) to (GMT)


# expand to how you’d actually use this -----------------------------------

#figure out how to use data, manipulate, and plot the data (ggplot)

nfy-error <- read_csv("data/2015_NFY_solinst.csv") #error. 
nfy_yay <- read_csv("data/2015_NFY_solinst.csv", skip=12) #yay 
nfy2 <- read_csv("data/2015_NFY_solinst.csv", skip=12, col_types="ccidd") #we want a character character integer double dobule 
glimpse(nfy2) #check


### TANGENT
nfy2<- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFY_solinst.csv", skip =12, col_types = cols(Date = col_date())) #read everything as normal, but just read the column Date as a different thing 
### end TANGENT 

#datetime doesn't exist yet, R will know to add it as a new column 
nfy2$datetime <- paste(nfy2$Date, " ", nfy2$Time, sep= "")  #play with putting a comma in sep and running glimpse 
    #paste date column, sep date time column by a space,
    # paste is smooshing columns together(?) 
glimpse(nfy2)
?paste


nfy2$datetime_test<-ymd_hms(nfy2$datetime, tz="America/Los_Angeles") 
  #run glimpse and see the column is date-time format (dttm)
glimpse(nfy2)
tz(nfy2$datetime_test)



# pull in new dataset…. ---------------------------------------------------

summary(mloa_2001)
mloa_2001$datetime <-paste0(mloa_2001$year,"-",mloa_2001$month, "-", mloa_2001$day, "-", mloa_2001$hour24, ":", mloa_2001$min)
#change it to a datetime ? 
mloa_2001$datetime<- ymd_hm(mloa_2001$datetime) #to be ymdhm

# $ creates the function AND places the data there. 



# CHALLENGE ---------------------------------------------------------------

# Challenge with dplyr & ggplot

# Remove the NA’s (-99 and -999) in rel_humid, temp_C_2m, windSpeed_m_s

mloa2 <-mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m != -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s !=-99, windSpeed_m_s != -999)

#OR 

mloa2 <-mloa_2001 %>% 
  filter(rel_humid != -99 & -999) %>% 
  filter(temp_C_2m != -99 & -999) %>% 
  filter(windSpeed_m_s !=-99 & -999)
  
# Use dplyr to calculate the mean monthly temperature (temp_C_2m) using the datetime column (HINT: look at lubridate functions like month())

mloa3 <- mloa2 %>% 
  mutate(which_month = month(datetime, label=TRUE)) %>% #pulls out name of month from the datetime column #new column titled "which_month" with the 3 letter word cfor month #label=false    -- gives the numeric month
  group_by(which_month) %>% 
  summarise(avg_temp=mean(temp_C_2m))

# Make a ggplot of the avg monthly temperature
mloa3 %>% 
  ggplot()+
  geom_point(aes(x=which_month,y=avg_temp),size=3,color="blue")+
  geom_line(aes(x=which_month,y=avg_temp))  #michael is checking this out 

# Make a ggplot of the daily average temperature for July (HINT: try yday() function with some summarize() in dplyr)









# FUN-CTIONS --------------------------------------------------------------

# any operation you want to perform more than once is something that can be done as a function. call func and pass it a new dataset, new parameters. 

log(5) #"5" is the argument. the output is the "return values"/plot

myt_sum <- function(a, b){
  thee_sum <- a+b
  return(thee_sum)
  }

myt_sum(3,7)

#Create a function that converts the temp in K to the temp in C (subtract 273.15 from K to get C)

mytemp <-function(K){
  C<- K - 273.15
  return(C)
}
mytemp(100)

list<- c(8,9,130)
mytemp(list)



# ITERATION INTRO ---------------------------------------------------------
#https://gge-ucd.github.io/R-DAVIS/lesson_iteration.html 

#you need to do the same thng over and over, change little things in a bunch of places, and either you mess up or worse it doesn't error and you did type something wrong. 

#TO RUN SAME CODE A BUNCH OF TIMES OVER AND OVER. DIFF FUNC.  

# rule 1 but not meaningful. if you want to run something 3+ times... ITERATE, don't copy paste. 


#write explicitly = "hard coding"
#but the more flexible and doing things multiple times on slightly diff datasets -- the better off we'll be. 


x<-1:10
log(x)

#for loops 

  # repeats some bit of code, each time with a new input value 

  #basic structure..... for()

for(i in 1:10){     #for each value i, in the vector 1:10, {do something}
  print(i)          # i gets created as a thing in environment. then gets updated to 2,3,4...10. then left, set as 10. 
} 


for(i in 1:10){
  print(i)
  print(i^2)     #print 1 and 1^2, then loop back up, i updates, print 2 and 2^2
}
  

# we can use the "i" value as an index 

for(i in 1:10){
  print(letters[i])
  print(mtcars$wt[i])  
}

#don't need to call it "i" but that's what people online tend to call it 

# if you want to store our results inside a forloop somewhere, you want to create something to hold the results (container) BEFORE we run the loop. Fill container with loop. 
  # if you keep adding on 1 at a time, R is like whoa how big should this be 
  # but you should probably know how big this should be. set this ahead of time saves you time 


# make a results vector ahead of time  ------------------------------------

results <- rep(NA,10)
for(i in 1:10){
  results[i] <- letters [i] #pull out the 1st letter from letters vec and store in my results vec 
}






