# Week 7  -  RDAVIS class code  -------------------------------------------
# Tue Feb 19 14:24:19 2019 

#Data Visualization in R
  #Lesson1 : https://gge-ucd.github.io/R-DAVIS/lesson_visualization_dos.html#historical_data_visualization
    #also check links in resources section at bottom of lesson 
 #Data Import & Export
  #Lesson2 : https://gge-ucd.github.io/R-DAVIS/lesson_data_import.html#reading_messier_data
  #Live Code: https://www.dl.dropboxusercontent.com/s/xd8ydvllqmpfja5/Week_7_LiveCode.R?dl=0 


# pre-lesson notes/talk ---------------------------------------------------

#history of data visualization
#get your point across quickly and cleanly (nothing flowery) 

################################################################################ EXPLORATION VS COMMUNICATION 
#...
################################################################################ COLOR

#program: color oracle. click for each of the types of colorblindness - change your whole screen to mimic what it would look like for that type of colorblindness

#think about colorblindness when doing figures. 
  # default package with ggplot. COLOR PACKAGE " viridis " colorblind friendly 
  # always stay away from color-scheme "rainbow" -- it has some really hard divides!

# check ggtheemes package
# color-brewer -- by cynthiabrewer (big name in mapping) -- colorschemes with good properties
  #"scale color brewer" in ggplot // and "viridis_c"(Continuous) or "viridis_d"(Discontinuous)



################################################################################  VISUALIZATION DO'S

# The most basic tip is keep it simple! Stick with a clean and clear message, what is your plot/figure trying to get across? Data visualization is effective when it is simple, and repackages data into a visual story that is easy to understand.

# 1) Label appropriately and legibly, including axes, and use text to highlight important bits
# 2) Use one color to represent each category, consider colorblind/BW friendly palettes
# 3) Order datasets using logical heirarchy (Make it easy for reader to compare values)
# 4) Use icons when possible to reduce unnecessary labeling
# 5) Pay attention to scale (e.g., start axis at zero not 2.4 to 3.5)
# 6) Include your data/outliers where possible

################################################################################ VISUALIZATION DON'TS

#A few things to avoid (which basically relates to keeping it simple):
  
# 1) Don’t try to add too much into one plot…keep it simple
# 2) Don’t add color uncessarily unless it provides a specific function
# 3) Avoid high contrast colors (red/green or blue/yellow)
# 4) Don’t use 3D charts. They can make it hard to discern or perceive the actual information.
# 5) Avoid ornamentation (shadowing, extra illustration, etc)
# 6) Avoid more than 6 categorical colors in a layout unless you looking at continuous data.
# 7) Keep fonts simple (avoid uncessary bold or italicization)
# 8) Don’t try to compare too many categories or data types in one chart

# top50 ggplot vis. (with code!) (gif!) >  http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html 

################################################################################ PUBLISHING PLOTS: COWPLOT

# make multiple plots...  diff data sets ... exports SINGLE image with the diff pieces on it that you want
#"plot_grid" is the cowplot func. 


################################################################################ PUBLISHING PLOTS: PATCHWORK

#ggaminate to do animations in ggplot  !!!! 
#patchwork lets you basically use "+" to do this 


# How to install a package from GitHub ------------------------------------

#most packages are in CRAN (central R archive network) "the official R thing" -gotta pass a lot of tests 
  #install.package is going into CRAN
#other packages are in GitHub 
  #to do this, you need "devtools" 
install.packages("devtools")
devtools::install_github("thomasp85/patchwork")



################################################################################
################################################################################

# Data Import & Export ----------------------------------------------------
#.rds or .rda file is how you'd save as an object after some giant modeling thing that takes a long time 
#.rds retains everything from that R session. don't need to translate to .csv 
  # stuff that isn't easily represented (not a table) (20mg .csv  >> compressed when .rds)
  # problem with that? .rds only readable in R (not python etc)


library(tidyverse)

wide_data <- read_csv("data/wide_eg.csv")
wide_data

# now using skip
wide_data <- read_csv("data/wide_eg.csv", skip = 2)

# loaded an RDA file that contained a single R object. RDA files can contain one or more R objects
load("data/mauna_loa_met_2001_minute.rda")

# write wide_data to an RDS file
saveRDS(wide_data, "data/wide_data.rds")

# remove wide_data (from environment)
rm(wide_data)

wide_data_rds <- readRDS("data/wide_data.rds")

# saveRDS() and readRDS() for .rds files, and we use save() and load() for .rda files

# other packages: readxl, googlesheets, and googledrive, foreign

library(rio)
rio::import("data/wide_data.rds")




# Dates and Times (Martha)  -----------------------------------------------



### Working with Dates and Times ####

library(lubridate)

sample_dates1<- c("2016-02-01", "2016-03-17", "2017-01-01")

as.Date(sample_dates1)
#looking for data that looks like YYYY MM DD

sample.date2<- c("02-01-2001", "04-04-1991")

sample.date2<- as.Date(sample.date2, format = "%m-%d-%Y")

as.Date("2016/01/01", format= "%Y/%m/%d")

#Jul 04, 2017

as.Date("Jul 04, 2017", format = "%b%d,%Y")
#b respresents shortened month, B is full month name









# Date Calculations -------------------------------------------------------


 

dt1 <- as.Date("2017-07-11")

dt2 <- as.Date("2016-04-22")

dt1

print(dt1 - dt2)

#time difference in weeks

print(difftime(dt1, dt2, units = "week"))

six.weeks <- seq(dt1, length = 6, by="week")

#Create a sequence of 10 dates starting at dt1 with 2 week intervals 

challenge <- seq(dt1, length = 10, by = "2 week")

ymd("2016/01/01")

dmy("04.04.91")

mdy("Feb 19, 2005")




#didn't get as far as we hoped. hmwk to be edited > up soon. 

























