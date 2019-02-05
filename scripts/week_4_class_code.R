####################################################################    [R-DAVIS-2019_01_29]
# Week 3: January 29, 2019

# Today: "Data Frames" https://gge-ucd.github.io/R-DAVIS/lesson_data_frames_ecology.html 
# class livecode:  https://www.dl.dropboxusercontent.com/s/pzeuwxk1jfbe2sr/Week_4_LiveCode.R?dl=0 

########################################################## IMPORT .CSV

download.file(url = "https://ndownloader.figshare.com/files/2292169",destfile = "data/portal_data_joined.csv")  #downloading .csv from RDAVIS class website > then say where to put it and what new  name it

surveys <- read.csv(file = "data/portal_data_joined.csv") #inside () hit tab > select "file" > do quotes > inside quotes hit tab > select the file  
### this way it helps autocomplete the path to the file for you without you remembering or trying to type it in. ----- "surveys <-" assigns the file to a word. 

surveys        #shows you the table, kinda messy 
head(surveys)  #shows you the whole table in a neater way



################################################################ let's look at structure 

str(surveys)

dim(surveys)
nrow(surveys)
ncol(surveys)
tail(surveys)
names(surveys)
rownames(surveys) 
#another really useful one 
summary(surveys) # more of a statistical look of what is contained here  
                 # "is there anything screwy or weird with my data?"
                 # notice which columns got NAs and which just got spaces, they're in two different categories



################################################################ SUBSETTING DATAFRAMES

# [row,col] in brackets 

# subsetting vectors by giving them a location index
animal_vec <- c("mouse","rat","cat")
animal_vec[2]


# dataframes are 2D! 
surveys[1,1]   #check that with head()
head(surveys)  # cool yes! there is a 1 in row1col1 
surveys[2,1]   # row2 col1 = 72!
               # row#,col# -- & if you forget, you can verify that! 


# whole first column (gives you a VECTOR)   
surveys[,1]  # conveniently, leaving it blank will do that, every row in first column

surveys[1] #single # with no comma, gives you a DATAFRAME with one column 
head(surveys[1])  



# pull out the first 3 values in the 6th column 
surveys[1:3,7] #7th column, 1st 3 entrees
               # gives you [blankvalue] F and M


               # colon is a shortcut to create a vector
3:10           # 7 indiv vectors 



# pull out a whole single observation
surveys[5,]   #gives you a DATAFRAME back
#drill yourself for every line that you run, what do you get back? VECTOR, DATAFRAME, ...?



# negative sign to exclude indices 
surveys[1:5,-1]
surveys[-10:34786] #get rid of everything but 1st 10 rows  #error
surveys[-c(10:34786)] #trick R. gives you 10:34786, and minus that. #gives you DATAFRAME 

str(surveys[-c(10:34786)]) # "ah yes, this is indeed a dataframe w 34786obs of 9variables"

surveys[c(10,15,20,10),] #it called it "10.1" because it doesn't want to give you "10" twice 
surveys[c(1,1,1),]       # same thing





################################################################ 
# more ways to subset

surveys["plot_id"]     # single column as data.frame
surveys[,"plot_id"]    # single column as vector 
surveys[["plot_id"]]   # single column as vector (useful for lists)

##  data.frame is a train
###  each train car is a column (train with 1 car, and all the stuff in it)
####  [[]] give me what is inside the train car (all the chickens)

# this is a nested approach to where you are. good for modeling and spatial data. amazing and useful. and hurts your brain. 

################################################################ 

#surveys$    
#this is a nice way to explore what's in your dataframe, see all the options (this is not complete)

surveys$year #single column as a vector





################################################################
################################################################ CHALLENGE START
#Challenge
#Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset.
nrow(surveys) #34786 rows
surveys_200<-surveys[200,]
surveys_200   #check
str(surveys_200) #yes it's a dataframe

#Notice how nrow() gave you the number of rows in a data.frame?
#Use that number to pull out just that last row in the data frame.
n_row<-nrow(surveys)
surveys[nrow(surveys),]

#Compare that with what you see as the last row using tail() to make sure it’s meeting expectations.
#Pull out that last row using nrow() instead of the row number.
tail(surveys) 
?tail

#Create a new data frame (surveys_last) from that last row.

surveys_last <- surveys[nrow(surveys),]

#Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.

surveys_middle <- surveys[nrow(surveys)/2,]
surveys_middle

#Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset.
surveys[-c(7:nrow(surveys)),]


############################################################ this made zero sense; spend through example 
################################################################ CHALLENGE END
#########################################################################################################



########################################################################### Finally, FACTORS 

# under the hood, they're being treated as INTEGERS
#once you create a factor, it has a predefined set of levels -- 

surveys$sex 

########################################################################### creating our own factor

sex<- factor(c("male","female","female", "male"))
sex #male(2)female(1) 2,1,1,2

class(sex)      #is factor  (high up, what are you)
typeof(sex)     #is integer (guts of, what are you really)

#LEVELS() gives back character level of the levels
levels(sex)     #gives character vector
levels(surveys$genus) 

nlevels(sex) # number of levels 
concentration <- factor(c("high","medium","high","low"))
concentration #listed them alphabetically "high low medium" 
#change the levels #lets change something and assign it back into itself
concentration <- factor(concentration,levels = c("low","medium","high")) #list order you want them 
concentration 

########################################################################### adding to a factor

concentration <- c(concentration, "very high")
concentration #changed the others to characters 123, but also now showing lowmediumhigh, but the integers under them!
#COERSES TO CHARACTERS IF YOU ADD A VALUE THAT DOESN'T MATCH CURRENT LEEVEL
#UUUUGH
#but maybe you don't want to work with a factor ... TEDIOUS? 

########################################################################### Let's just make em characters

as.character(sex)   #gave back levels 
########################################################################### factors w numeric levels
year_factor <- factor(c(1990,1923,1965,2018))
as.numeric(year_factor) #gave back levels 
as.numeric(as.character(year_factor)) #and now you have the years as numbers not characters. no quotes. whew.
#this will actually give us a numeric vector

############################################################################ why the heck all the factors 

#read.csv has one of the more controversial defaults in the R world 
?read.csv #take any character string columns it can find and turn them into factors 

#DEF: stringsAsFactors	-- "logical: should character vectors be converted to factors? Note that this is overridden by as.is and colClasses, both of which allow finer control."

#toFix 
surveys_no_factors <- read.csv(file="data/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys_no_factors)

# recommended way
# instead of "as.numberic(as.character)" do...
as.numeric(levels(year_factor)) [year_factor] #results are stored as integers (alphabetically (3,1,2,4))


############################################################################ ugh
############################################################################ RENAMING FACTORS 

# $ addresses Column by name 

#reassign something to "sex" 

sex<-surveys$sex
levels(sex)
levels(sex)[1] #pulling out the first entry of that vector 
levels(sex)[1] <- "undetermined"
levels(sex)
head(sex)

############################################################################ 
############################################################################# 
############################################################################ 
############################################################################ 
########################################################################### 
############################################################################ 
############################################################################ WORKING WITH DATES 


#PACKAGES are collections of functions (and sometimes data) that go together. Package that helps you do one model, one for color pallets. get it using library()

library(lubridate) #none
install.packages("lubridate") #TIP, DO NOT put it in the script because it will reinstall each time. 
#CHRISTINE TIP. rather than do it in the console, maybe just # it so you/people know which package you even need but it doesn't re-run each time. 
library(lubridate) #it works 


my_date <-ymd("2015-01-01")
my_date
str(my_date)

#paste takes values and stiches them together

my_date <- ymd(paste("2015","05","17",sep = "-" )) #sep is a character string that will sep the things before it with a dash 
my_date


paste(surveys$year, surveys$month, surveys$day, sep="-") #goes through every single entry and stitch them together in the proper order 
#create new column called ...
surveys$date<-ymd(paste(surveys$year, surveys$month, surveys$day, sep="-"))
#warning 129 failed to parse / work 
surveys$date

surveys$date[is.na(surveys$date)]






