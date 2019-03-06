#week 9 - class code 

# iteration - lecture tab: https://gge-ucd.github.io/R-DAVIS/lesson_iteration.html
# live code : https://www.dl.dropboxusercontent.com/s/0hcevv86ui8rpgo/Week_9_Live_Code.R?dl=0 



# Back to Iteration (for loops)---------------------------------------------------------------

# First argument is the data/thing you want to iterate ACROSS
# Second argument is the func you want to APPLY to each thing 
sapply(1:10, sqrt)




# 1st: for loop 
result <- rep(NA, 10) # create an empty box that has enough space to hold the for loops
for(i in 1:10){       # create for loop 
  result[i] <- sqrt(i)/2
}
result                # check 

# 2nd:  now use sapply 
result_sapply <- sapply(1:10, function(x) sqrt(x)/2) #this takes away from the structure of the for loop; ok for simple work 
        #this does the same thing. a little cleaner, didn't need to create a "results" vector 
result_sapply #check 




# additional arguments in "apply" ----------------------------------------
mtcars_na<-mtcars

mtcars_na[1, 1:4] <-NA #we intentionally put NAs in there

sapply(mtcars_na,mean)
sapply(mtcars_na, mean, na.rm=T) #each time the mean func applied, it's like running: 
mean(mtcars_na$mpg, na.rm=T)





# back to the tidyverse --------------------------------------------------

mtcars %>% 
  map(mean)  #gave us a list 

mtcars %>% 
  map_dbl(mean)#gave us a table? 

mtcars %>% 
  map_chr(mean) # gives you back characters 

#map_df gives dataframe back 

#map2_ for 2 sets of inputs
map2_chr(rownames(mtcars), mtcars$mpg, function(x,y) paste(x, "gets", y, "miles per gallon"))
    #take 1st value in row name and 1st value in mpg and smash together and do it for every set of inputs



# conditions / conditional things (do this, only if x) - er there was a way to do it. 


# complete workflow ~ -----------------------------------------------------
# Lecture tab, complete workflow section: https://gge-ucd.github.io/R-DAVIS/lesson_iteration.html#complete_workflow 

#attempt to scale our qeights of mtcars 

mtcars$wt[1] #the 1st weight in our dataset  
(mtcars$wt[1] - min(mtcars$wt)) / (max(mtcars$wt) - min(mtcars$wt)) #minus minimum of mtcars weight and divide by thing 

# generalized verson of the above 
(x-min(x))/(max(x)-min(x))

# make that into a function now 

rescale_01 <- function(x){
  (x-min(x))/(max(x)-min(x))
}
rescale_01(mtcars$wt)


# iterating!  -------------------------------------------------------------

map_df(mtcars, rescale_01)

############################################################################################
############################################################################################
############################################################################################


# r markdown!!  -----------------------------------------------------------

# can use it as a notebook to write up your analysis; 
    # yay my model works > move the working code to an R markdown doc and write copious notes


#contains plain text and code chunks (between ''' and ''' )













