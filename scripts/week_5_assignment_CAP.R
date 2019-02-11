# WEEK 5 ASSIGNMENT
# Alright folks, we’ve ventured into the tidyverse! We’re going to test out your dplyr skills, pipe (%>%) some data, and make a tibble or two.

# DPLYR CHEATSHEET:   https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf 

############################################################################################
############################################################################################ MY NOTES (START)
#justcurious...
?tidyverse
tidyverse_packages(include_self = TRUE) #what does tidyverse actually have again? er.not helpful. 
#here: https://www.tidyverse.org/packages/ 

#SO FAR IN TIDYVERSE: 
# mutate()    -- adds new variables that are functions of existing variables (adds column to existing df)
# select()    -- picks variables based on their names.
# filter()    -- picks cases based on their values.
# summarise() -- reduces multiple values down to a single summary. (spits out entirely NEW tibble)
# arrange()   -- changes the ordering of the rows.

############################################################################################ MY NOTES (END)
############################################################################################



# Part I: Enter the Tidyverse

#1) Create a new script in your r-davis-in-class-yourname project, and name it w_5_assignment_ABC.R, with your initials in place of ABC. Save it in your scripts folder.




#2) Read portal_data_joined.csv into R using the tidyverse’s command called read_csv(), and assign it to an object named surveys.
install.packages("tidyverse")  #dont need to install each time, but do need to call it. 
library(tidyverse)
surveys<-read_csv("data/portal_data_joined.csv") #hello dataframe
surveys





#3) Using tidyverse functions and pipes, subset to keep all the rows where weight is between 30 and 60, then print the first few (maybe… 6?) rows of the resulting tibble.
?filter
?slice
?head
### WHY DIDNT THIS WORK? -- produced "value" instead of "data" -- Why? 
#newt_r_cute1<-surveys %>%
#filter(weight>30 & weight<60)%>%
#slice(1:6) %>%   # or use "head()"? 
#View             #why does it null if I try to "assign <-" this?

# OH !! 

newts_r_cute<-surveys%>% #🦎
  filter(weight>30 & weight<60)%>%
  head() #prints 1st 6 rows of resulting tibble
# OR !! 
newts_r_cute1<-surveys %>%
  filter(weight>30 & weight<60)%>%
  slice(1:6)  ## It does work! Just don't use VIEW()


#4) Make a tibble that shows the max (hint hint) weight for each species+sex combination, and name it biggest_critters. Use the arrange function to look at the biggest and smallest critters in the tibble (use ?, tab-complete, or Google if you need help with arrange).
biggest_critters<- surveys %>% 
  group_by(species,sex) %>%
  summarize(max_weight = max(weight,na.rm=TRUE)) %>% 
  arrange(desc(max_weight)) #arrange by vecor max weight in descending order
str(biggest_critters) #check 



#5) Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

#METHOD 1
RowSumNA<-surveys %>% 
  tally(rowSums(is.na(surveys)))  #well this just told me we have 7599 NAs total

#METHOD 2
surveys %>% 
  filter(is.na(sex)) %>% #look at all the NAs in df, but you have to go column by colum (one by one)
  tally()  %>% View 

#METHOD 3
SurveyNA<-colSums(is.na(surveys)) #heeeeey.😏
SurveyNA 

#Answer: sex(1748), hindfoot_length(3348), weight (2503)  
1748+3348+2503 # =7599! Same number as in METHOD 1. 

####################### oops, did you want to know *which* species? *which* plot? *which* taxa? If so, add **group_by()** line. 
#EXAMPLE
surveys %>% 
  filter(is.na(sex)) %>% #look at all the NAs in df, but you have to go column by colum (one by one)
  group_by(sex) %>% View 









#6) Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight. The resulting tibble should have 32,283 rows.

surveys_avg_weight<-surveys %>% 
  filter(!is.na(weight)) %>% #get's rid of the NA's 
  group_by(species,sex) %>% #group for species/sex combo
  mutate(mean_weight = mean(weight,na.rm=TRUE)) %>% #add column w/ mean weight of species/sex combo
  select(species,sex,weight,mean_weight) #select for certain columns. could have used "summarize" if we didn't also want original weight in this 







#7) Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).
AbvAvg<- surveys_avg_weight %>% 
  mutate(above_average = weight>mean_weight)
str(AbvAvg) #just checkin' "TRUE" is a "logic value" 😬 it is indeed 









#8) Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?

?scale 
#DEF SCALE: calcs the mean and standard deviation of the entire vector --> and then scales each element by those values by subtracting the mean and dividing by the sd. (If you use scale(x, scale=FALSE), it will only subtract the mean but not divide by the std deviation.)

surveys %>% 
  group_by(species) %>% 
  mutate(scaled_weight = scale(weight)) %>% 
  arrange(desc(scaled_weight)) %>% 
  View
   
#RESULTS: Low (-4.8) and many others... High (10 and 15) ... some NAs

#test... if you don't divide by std dev...?
surveys %>% 
  group_by(species) %>% 
  mutate(scaled_weight = scale(weight, scale=FALSE)) %>% View  #LOL, well that's just worse. 

# I don't understand these results? but the code...worked.  



         




############################################################################################ 
############################################################################################ 
#Part II: Code Review
#1) Find your code partner’s repository on GitHub, click on the scripts folder, and find the script named w5_assignment_ABC.R
#2) Click on the script, then find the RAW button on the right hand side of the screen. Click on RAW.
#3) You should see a plain text version of the script. Right click anywhere on the page, and select “Save As”, save the script to your scripts folder in your repository. Make sure to change the file extension to .R (instead of .txt).
#4) If you can’t save your partner’s file in this way, you can copy the text from the RAW view, then create a new .R file in your RProject, and paste the text there.
#5) Now, if you open up your RProject where you saved the script, you should see it, and better yet, you should have the same path/folder structure that is used in the script (we hope!).
#6) Try to run your partner’s script, stepping through each question, and compare your methods and answers to theirs. Did they use the same steps in the same order? Do their answers look like yours? If not, try to figure out why!
#7) Any questions? comments? Issues? Remember you can always tag us using individual names when you file an issue in the Discussion repository: @marthawohlfeil, @mcmaurer @ryanpeek, etc