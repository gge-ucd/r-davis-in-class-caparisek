####################################################################    [R-DAVIS-2019_01_22]
# Week 3: January 22, 2019

##########################################################  BEST PRACTICES FOR SPREADSHEETS
# https://gge-ucd.github.io/R-DAVIS/lesson_spreadsheets_condensed.html 


# excel is good, but diffficult to retrace your steps in excel and easy to put a slightly diff formula to an adjacent box and not know what happened.
# so make excel easier to use and how to make it putting in R easier * 


########################################################## how to enter data from the outset(EXCEL)

# never modify your raw data
# keep a plain-text file of notes on what you did in the excel file to track it. 
# computer cant understand color, italics, bold, etc. > so never use color/bold/spacing to highlight areas of your data. 

#### ex: instead of highlight yellow every data collection day it was raining --> new column: rain? yes or no. 

# dont put more data into a single row than is necessary 
#### ex: have units in the table header not alongside each number
#### ex: species-sex column? should be in 2 columns! 
#### ex: date column! We'll talk about that. 

# if table is too big, you can freeze your column headers

##########################################################  ZEROS VS BLANKS 
# enter zeros as zeros, not a blank. -- zero is data. 
# Blank = NA or na = Throw out 
#### pretty easy to filter out the NAs in R 

# If you're thinking at this point::  "oh shit, my data doesn't look like any of this"? Not to worry!  -->   Use FIND&REPLACE EXCEL TOOL. 

##########################################################  TABS IN AN EXCEL SHEET 
#R can only read the first tab. Don't have multiple tabs in excel. > can I just make a new column instead of a new tab? 

########################################################## HEADERS OF COLUMNS

# no spaces in the column names! R can't handle it. Use underscores or varied capitalization. 
# no characters (%,&,$)
# no multiple tables in the same spreadsheet 
# GOT METADATA? -- instead of using a "comments" functionality in excel or tab... just create a new document with it and put that file in your R folder. 

########################################################## DATE FORMAT

# dates/times can be data. it's awful in excel. 
###  how excel reads a date::  (PC: # of days since 1900) (MAC: # of days since 1904)

#use 3 separate columns for DAY/MONTH/YEAR and another for TIME

#how to extract DAY/MONTH/YEAR from a single column "1/08"(2015)  (cell A3)
### excel function  =MONTH(A3)    =YEAR(A3)      =DAY(A3)   etc 
###                    Julian Day?(1-360days()   =A3-DATE(YEAR(A3))
#### and there are R packages that will take these date columsn and pull them back together reall nicely. 

########################################################## EXCEL TRICK, ESP IF SOMEONE WHO IS NOT YOU IS ENTERING YOUR DATA.... 

#EXCEL has QUALITY CONTROL mechanisms... 

#Data tab > "Data Validation" > tell it whats OK to be in certain columns. set up error message alerts, etc. 

########################################################## SORT DATA COLUMN
#always want to "expand this selection" to it applies it to ALL the columns not just your one highlighted column. 

########################################################## EXPORT DATA FOR R
#export as a .CSV or .TSV 

########################################################## IMPORT DATA INTO R

read.csv("data/tidy_data_sample.csv") #tell it the path. since we are in an R project the path will be short... just the folder in this project and then the name of the file! 


####################################################################    
#################################################################### 
####################################################################  MICHAEL 
# Transition Martha --> Michael
# https://gge-ucd.github.io/R-DAVIS/lesson_vectors.html
####################################################################  VECTORS AND DATA TYPES

                        ### A VECTOR IS JUST A SEQUENCE OF VALUES/CHARACTERS/NUMBERS... 
# before it was...
x<-4
#concatinate (or combine) "c" is a vector. 
weight_g <- c(50,60,31,89)
#look at "environment" and notice differences
weight_g  #hit command enter on this and it spits it into the console, without commas in output

animals <- c("moose","rat","dog","cat")
animals

########################################################## VECTOR EXPLORATION TOOLS

length(weight_g) #output 4, there are 4 entries in this vector
length(animals)  #output 4

#everything within a vector has to be the same data-type (all numbers, all characters)
### "class" func will tell you the type of data 
class(weight_g) #output "numeric"
class(animals)  #output "character" 

str(weight_g) #gives you structure of an object (for x, a vector, etc)
              # num [1:4] 60 60 31 89

weight_g <- c(weight_g,105) # "modifying in place" 
                            # now it has 5 values. run it again, and again? get 105 listed 3x! 
                            # carful of not to have something multiple times
weight_g <- c(25, weight_g) # this added the number to the start of the list

# "atomic vector type" are ones you can't split any further. the simplest expression R knows what to do with. 1st 4 are the ones we normally deal with. 
              # 6 TYPES OF ATOMIC VECTORS
              # numeric eg, "20" (aka: double eg "20.2")
              # character
              # logical (true or false)
              # integer
              # complex
              # raw (0s and 1s)
typeof(weight_g) #tells you the atomic vector type : double
weight_integer<-c(20L, 21L, 80L) #this is how R would recognize integers
class(weight_integer)
typeof(weight_integer)






####################################################################    
#################################################################### 
####################################################################   Challenge START

# We’ve seen that atomic vectors can be of type character, numeric (or double), integer, and logical. But what happens if we try to mix these types in a single vector?
  
# What will happen in each of these examples? (hint: use class() to check the data type of your objects):
  
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")
# Why do you think it happens?
#How many values in combined_logical are "TRUE" (as a character) in the following example:

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

#You’ve probably noticed that objects of different types get converted into a single, shared type within a vector. In R, we call converting objects from one class into another class coercion. These conversions happen according to a hierarchy, whereby some types get preferentially coerced into other types. Can you draw a diagram that represents the hierarchy of how these data types are coerced?
  
####################################################################    
#################################################################### 
####################################################################   Challenge END

















