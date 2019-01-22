
####################################################################    [R-DAVIS-2019_01_15]
# Week 2: January 15, 2019
# Week 2: Live Code (1st half also in "w01-fix-readme-caparisek" and "R-DAVIS-class"{deleted} bc I don't know which R Project we're keeping for official class notes!)



2+2  #COMMAND + ENTER on a Mac. 

#if file header red = unsaved
#title files with underscore, no spaces. 


# Notes. 1/15/2019
## 1. Class site: Course Materials: "Orientation to Programming"
## 2. Write clear notes in your code! 
## 3. Terminal (can interact with whole computer; diff language; not R) vs Console (speaking to R)

## No need to highlight line; just cursor on line. 2 lines before you finish = it knows it's all part of the same command 
4+ 
  3

8*2  #anything after hashtag R will ignore. Comments are for people. 
# your worst enemy is you from 6 months ago. Leave well commented out code. 

## quotes, parenth., etc, it will close it for you. 
## R does not care about white space. 

2/20000000 #gives you scientific notation
1e9 #also makes sense to R 

#
#
#
#
#

# FUNCTIONS (the main way you get stuff done)

#name of func, (), and argument inside it. 
log(4)
#type 3 letters and R will helpfully ask you which func. If it doesn't, hit TAB and it will pop up. 
#hit tab while IN THE FUNCTION, and it will remind/explain the arguments you need
log(x=4) #same output as above. being more explicit is all. 
#you can next func within each other 
sqrt(log(4))
sqrt(1.386294)


#
#
#
#
#


#COMPARISONS

##can test equality
1==1 # TRUE    (is 1 = to 1? )
1!=2 # TRUE    (does 1 NOT EQUAL 2 )
1!=1 #FALSE
1<2 #TRUE
1>=-9 #TRUE    (greater than or equal 2)

#
#
#
#
#

# variables and assignment ... VECTOR

##assignment opperator ...  <-  #here, whitespace does count. no space. 
x<-9
x #is now the value 9. 
x<-3 #x is now 3. x is a storage device. 
log(x) #x is 3, so log(3)

x<-x+1 #stores "4"
x      ## WARNING! if you run the line above (line 75, x+1) it keeps adding. becomes 5,6,7 each time you run it. modifies it each time. This is called  "MODIFYING IN PLACE"  

#in R code you absolutely cannot have spaces...
x and z <- 3  #error
x_and_z <- 3  # OR USE ... xAndZ
xAndz <- 3    #heigh_of_plant (tab complete can also help us finish the name of variable)



#
#
#
#
#

#HELP


# ?functionname = a help panel pops up
?mean #command+enter 
## first it tells you the func and {package it's in} 
## tells you all options contained in a function. 
?base
library(help="base")
# looking for more help? 
# 1. access R-DAVIS resource page. (https://gge-ucd.github.io/R-DAVIS/resources.html), 
# 2. R studio's cheat sheets, 
# 3. StackOverflow...


#
#
#
#
#


# R telling you stuff  ("Error" vs "Warning" vs "Message")

log_of_a_word <- log("word")  #ERROR message: non-numeric func! 
# R's errors vary in level of useful. 
## This error is fairly clear. Math on a word doesn't make sense. 
log_of_a_word #error: object not found. It doesn't exist; we neverp ut anything into it. 

log_of_a_negative <- log(-2) # WARNING message: In log(-2) : NaNs produced
## NaN = "not a number" 
log_of_a_negative #does WORK, it does contain something. but contains NaN

#message - the lowest tier of worry
message("hey folks")


#
#
#
#
#

#Challenge
#Which elephant weighs more? Convert one’s weight to the units of the other, and store the result in an appropriately-named new variable. Write a command to test whether elephant1 weights more than elephant2 (1 kg ≈ 2.2 lb).

#elephant1_kg <- 3492
#elephant2_lb <- 7757

elephant1_kg <- 3492
elephant1_kg
elephant2_lb <- elephant1_kg * 2.2  #by not writing "3492", if you need to go back and fix the value, you only need to change it once, bc in future it's "assigned" to "elephant1_kg"
elephant2_lb
#check 
elephant1_kg < elephant2_lb #true 

#
#
#
#END MICHAEL (MOOSE) TEACHING
#BREAK
#BEGIN MARTHA TEACHING
#
#
#

# PROJECT MANAGEMENT. 
# 1. easier to share code with someone (even if just in email)
# 2. easier for you to pick up project after a time away from it.
#
# Treat your Raw Data as "read only". 
### After you/undergrad entered data into excel file. Now? Never touch that file again. 
### What to make a change? Make a copy of that file, rename, retitle a column. 

# Treat generated outputs as disposable 
###next week we take a .csv file into R and manipulate it in R ... and save new .csv file that's been manipualted. We don't want the new file that's saved to be floating, we want to be able to REPRODUCE it from the scripts. 

#
#
#
#
#

# # # What's an "R project" 

#a folder.
## within: things that don't exist in ours yet
#whenever you start a new project in R (mini project. here, please analyze this data for me.)
##start a new project in R. make these folders 

# FOLDERS: 
## (Working Directory main project folder)
## 1. data
## 2. data_output
## 3. documents
## 4. fig_output
## 5. scripts 

# Create a project, not in GitHub but on your computer. 
# In R Studio: File > new project > new directory (not version control)
# don't have spaces in file/folder name! bc R doesn't like "pathway" to have spaces. 
# and don't move it afterward or it's painful. 
# > now all R-DAVIS class code is "R-DAVIS-class" 

#can change the name of the folder were project lives. (outside the folder) that's ok. rename INSIDE could be a problem. 
#.Rproj folder is a path to where it lives on computer, if you change any part of that path your computer is lost. 


####################################################################
####################################################################
####################################################################

#Files tab. "New Folder" 
# in Files tab (on one of these 4 panes, bottom right probably.) > "NEW FOLDER" 
# Folders: data,  script, data output, figures
getwd() #tells you where your file is living. good to check. 

# Coding etiquette style guides: https://style.tidyverse.org/


#QUESTIONS (1)
#absolute filepath -- whole thing starting from your harddrive 
#relative filepath -- relative to your wording directory (wd). if you're good about keeping things straight, then yes it keeps a nice tidy package. you could theoretically send that FILE to someone and they have the neat portable package (working directory). 
## the goal is for this to WORK ... 
## GIS work? Genetic Data? These may not be very portable... 
###this might need to go online, or somewhere. there are ways to build it in and have it still be reproducable. 

#QUESTIONS (2)
#How to put a picture into a project, and put that picture into a script or markdown document like last week.
##put a picture in our figures folder using Finder

## in an RMarkdown file (not R script) Do...
#    ![](figures(bearattack)) 


