# Week 3: February 05, 2019 - R-DAVIS Class Code - Week 5

# GUESS WHAT I FOUND:  
    # https://twitter.com/mathematicalm3l/status/1090720774464421889/video/1
    # https://github.com/melissanjohnson/pupR 

# Step 1: install package "devtools" -- for helping develop your own package.
# Step 2: run the line:    devtools::install_github("melissanjohnson/pupR") 
devtools::install_github("melissanjohnson/pupR")   
    # check console to answer, option 1-7, just pick 7 ("dontupdate")
    # note: if console has a "1:" instead of ">" it's waiting for this             answer! Click next to "1:" and click "esc", or answer "7"


library(pupR)
pupR()









# Ok, now let's get to class
#############################################################################


# last week: bracketing and subsetting using base-R 
            # good to know, but in big datasets or complicated things, cumbersome. so use tidyverse. 

# Today: " Tidyverse World: dplyr, ggplot, etc." 
          # https://gge-ucd.github.io/R-DAVIS/lectures.html 
          # https://gge-ucd.github.io/R-DAVIS/lesson_dplyr_ecology.html
# class livecode:  https://www.dl.dropboxusercontent.com/s/knklng647ndc3sb/Week_5_LiveCode.R?dl=0


#############################################################################################

# install.packages("tidyverse")  #dont need to install each time, but do need to call it. 
library(tidyverse) #scary colored text, checks and some red x's. it's saying watch out these are named the name thing, you might have a problem later, but I'll download it anyway - it says. 
library(dplyr)

# download.file(url="https://ndownloader.figshare.com/files/2292169",destfile = "data/portal_data_joined.csv")   ## if you don't have it 


#read.csv is base R
#read_csv is tidyverse 
surveys<- read_csv("data/portal_data_joined.csv")  
          #if doesn't work: surveys<- readr::read_csv("data/portal_data_joined.csv")
str(surveys) #notice the top says it's a "tibble dataframe" (tbl_df). Columns are characters. Or you can click on it in your environment and view in table format. TBL is a fancy dataframe. A tidyverse construct. prints nicer, fancier looking, not really different. fresh coat of paint 
# [ tbl_df  -- table dataframe -- tibbledataframe (said really fast)] 

############################################################################# dplyr functions

#select is used for selecting columns in a dataframe 
select(surveys, plot_id, species_id, weight)    #plot_id, species_id, and weight


#filter is used for selection rows
filter(surveys, year == 1995) #prints table with only the years from 1995 

surveys2 <- filter(surveys,weight<5) #new df that filters weights that are less than 5
surveys_sml <-select(surveys2, species_id, sex, weight) #creates new df with those 3 columns of the df that has weight <5


#but this can get tedious too! so use Pipe! 
############################################################################# #Pipes  %>% 

#Pipes  %>%    Shortcut -- PC: cntrl+shift+M   // MAC:  cmd+shift+M
#   %>%    aka "then/and then" do this 
#mcgritter package is for piping without tidyverse, but you could just load tidyverse each time too 


# ., 


surveys %>%               #tells following commands that what is left of the pipe to go into it
  filter(weight<5) %>%    #close the pipe   
  select(species_id, sex, weight)

############################################################################# CHALLENGE START

#Challenge! Using pipes, subset the surveys data to include individuals collected before 1995 and retain only the columns year, sex, and weight.

surveys %>% 
  filter(year<1995) %>% 
  select(year,sex,weight)    #could you select before you filter? in this case, yes. but sometimes if you switch order you might unselect a column you wanted. just keep track of that 

############################################################################# CHALLENGE END

############################################################################# MUTATE

View(surveys) #ok, checked the table's appearance. 

#mutate is used to create new columns 

surveys_kg <- surveys %>%
  mutate(weight_kg = weight/1000) %>%  #perform an operation on a column to create new column (kg one) 
  mutate(weight_kg2 = weight_kg * 2)   # another new column / if you called it the same name, it would replace it 

#! is a negating operator "is not NA" 


#notice we have all these NAs in our data... 
surveys %>%
  filter(!is.na(weight)) %>%  #use is.NA to ask if it is an NA or not. filters the NAs out 
  mutate(weight_kg = weight/1000) %>%  
  summary

#use "complete cases" to filter out ALL of the NAs







############################################################################# CHALLENGE START

#Challenge! Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.
#Hint: think about how the commands should be ordered to produce this data frame!

#filter is the largest operation, then mutate, then select 
  
surveymchallenge <- surveys %>%
  filter(!is.na(surveymchallenge) %>% 
  filter(surveymchallenge<30)) %>% 
  select(species_id, hindfoot_half) %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  summary()
  
#ughh out of orderrrrrrr
#ANSWER 
surveys_hindfoot_half <- surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>%
  filter(hindfoot_half < 30) %>%
  select(species_id, hindfoot_half)


############################################################################# CHALLENGE END 
############################################################################# GROUP-BY 

#group_by is good for split-apply-combine

surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm=TRUE)) %>%  View   
            #remove NAs in the weight column for means and get mean weight for male/female/NA
            #look, add view here! notice it's not named anything or saved in the environment 
            


#SO FAR IN TIDYVERSE: 
    #filter, select, mutate, group_by, summarize
          ##mutate added new columns to existing dataframe, mutated it 
          ##summarize spits out entirely NEW tbl


surveys %>%
  filter(is.na(sex)) %>% 
  View #way to look at all the NAs in the data frame 

surveys %>%  #tells us where the NAs are in species 
  group_by(species) %>% 
  filter(is.na(sex)) %>% 
  tally()                        # NEW 

# you can use group_by with multiple columns

surveys %>% 
  filter(!is.na(weight)) %>% #get's rid of the NaN's 
  group_by(sex,species_id) %>%
  summarize(mean_weight = mean(weight,na.rm=TRUE)) %>% 
  View  #NaN's gone 

#why did the NaNs happen? because maybe you said males of this sp divided by N -- but there were no males of that species, only females. so it divided by zero (can't do that) and it gave you something but it's wrong. Maybe that's why it happens. 

surveys %>%                   #now I want to know the min_weight too 
  filter(!is.na(weight)) %>% 
  group_by(sex,species_id) %>%
  summarize(mean_weight = mean(weight), min_weight=min(weight)) %>% 
  View  


##########################################################################################  TALLY FUNCTION

surveys %>%
  group_by(sex) %>% 
  tally( ) %>%  View 

#tally is for diving into guts of dataframe 
# assign to something? and 
# tally will give you a tbl 
?tally #counting
#tally () same as group_by(something) %>%  summarize (new_column=n)


################################################################################### GATHERING AND SPREADING 

# dataframe that has mean weight of each species of each plot 

#spoiler alert, use gathering and spreading

#SPREADING: takes long format dataframe & spreads it to wide (lot of rows, a few columns)
#Spread

surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

surveys_spread <- surveys_gw %>% 
  spread(key=genus,value=mean_weight) #if your computer forgets the package use "tidyr::" before "spread" 

# in our lesson, see figure under "reshaping with gather and spread" 
# https://gge-ucd.github.io/R-DAVIS/lesson_dplyr_ecology.html#reshaping_with_gather_and_spread


surveys_gw %>% 
  spread(genus,mean_weight,fill=0)  #func knows the first thing is KEY and 2nd is VALUE
  #fill=0 filled the NAs with zero 








#GATHERING: for WIDE format (many columns, few rows)  >TO> long format
#you'll do this a lot less 
#find this more useful to get from FIELD DATASHEET to something that's more useable 
#takes a few more things 
#see fig 2 in the link above  


surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot_id)  #use all columns but plot_id to fill genus 
View(surveys_gather)














## BTW -- the package was made by HadleyWickam, from NewZealand. When the package first same out, functions were like "summarise" not "summarize" and people made fun that those in UK or USA couldn't use func on words they were used to. You had to write it with S! New version, you can use either, they do the same thing. 

