# WEEK 5 ASSIGNMENT
# Alright folks, we’ve ventured into the tidyverse! We’re going to test out your dplyr skills, pipe (%>%) some data, and make a tibble or two.

############################################################################################
# Part I: Enter the Tidyverse

# Create a new script in your r-davis-in-class-yourname project, and name it w_5_assignment_ABC.R, with your initials in place of ABC. Save it in your scripts folder.

#Read portal_data_joined.csv into R using the tidyverse’s command called read_csv(), and assign it to an object named surveys.

surveys<-read_csv("data/portal_data_joined.csv") #hello dataframe

install.packages("tidyverse")  #dont need to install each time, but do need to call it. 
library(tidyverse)
?tidyverse
tidyverse_packages(include_self = TRUE) #what does tidyverse actually have again? er.not helpful. 

# here: https://www.tidyverse.org/packages/ 

# mutate()    -- adds new variables that are functions of existing variables
# select()    -- picks variables based on their names.
# filter()    -- picks cases based on their values.
# summarise() -- reduces multiple values down to a single summary.
# arrange()   -- changes the ordering of the rows.

#SO FAR IN TIDYVERSE: 
                     #filter, select, mutate, group_by, summarize
                                             ##mutate added new columns to existing dataframe, mutated it 
                                             ##summarize spits out entirely NEW tbl

                  #Hint: think about how the commands should be ordered to produce this data frame!
                  #filter is the largest operation, then mutate, then select 

############################################################################################

#Using tidyverse functions and pipes, subset to keep all the rows where weight is between 30 and 60, then print the first few (maybe… 6?) rows of the resulting tibble.

?filter
?slice
str(surveys)

newtscoot <- surveys %>%
  filter(weight>30 & weight<60)%>%
   slice(1:6,) %>% View             #works!?

str(newtscoot) #null....

#Make a tibble that shows the max (hint hint) weight for each species+sex combination, and name it biggest_critters. Use the arrange function to look at the biggest and smallest critters in the tibble (use ?, tab-complete, or Google if you need help with arrange).

biggest_critters<- newtscoot %>% 
  






Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight. The resulting tibble should have 32,283 rows.

Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).

Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?
  
  Part II: Code Review

Find your code partner’s repository on GitHub, click on the scripts folder, and find the script named w5_assignment_ABC.R

Click on the script, then find the RAW button on the right hand side of the screen. Click on RAW.

You should see a plain text version of the script. Right click anywhere on the page, and select “Save As”, save the script to your scripts folder in your repository. Make sure to change the file extension to .R (instead of .txt).

If you can’t save your partner’s file in this way, you can copy the text from the RAW view, then create a new .R file in your RProject, and paste the text there.

Now, if you open up your RProject where you saved the script, you should see it, and better yet, you should have the same path/folder structure that is used in the script (we hope!).

Try to run your partner’s script, stepping through each question, and compare your methods and answers to theirs. Did they use the same steps in the same order? Do their answers look like yours? If not, try to figure out why!
  
  Any questions? comments? Issues? Remember you can always tag us using individual names when you file an issue in the Discussion repository: @marthawohlfeil, @mcmaurer @ryanpeek, etc.

Thanks!