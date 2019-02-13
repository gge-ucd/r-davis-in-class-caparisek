# February 12, 2019 - R-DAVIS Class Code - Week 6


# last week: tidyverse
# Today: " Tidyverse World: dplyr, ggplot, etc.--- finish a thing in DPLYR, then focus on GGPLOT" 
# Lecture GGPLOT https://gge-ucd.github.io/R-DAVIS/lesson_ggplot_ecology.html 
# Class Week6 files: https://gge-ucd.github.io/R-DAVIS/lectures.html 


library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")




################################################################################## MARTHA FINISHING IN DPLYR

#take all NAs out of the weight, hindfoot_length, and sex column 
surveys_complete <- surveys %>% 
  filter(!is.na(weight, hindfoot_length,sex)) #error, filter can do only one at a time 
#TRY AGAIN, DIFFERENT WAY
surveys_complete <- surveys %>% 
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex)) # Yes! 

species_counts <- surveys_complete %>% 
  group_by(species_id) %>% 
  tally() %>% #R creates a new column called "n"
  filter(n >= 50) #lists the species counted more than 50 times

surveys_complete<-surveys_complete %>%  #write over the file
  filter(species_id %in% species_counts$species_id) # now we want to tell R to only keep (species_counts) data from the (surveys_complete)

# %in% -- take the species_id .. in this column (%in%)...species_count ($ calls column in a dataframe) column species_id. 
species_keep <- c("DM","DO") #and now can use %in% on this







#############################################################################   WRITE YOUR DATAFRAME TO .CSV 
# to share your code with collaborators 
# important to keep raw data files separate from those generated with an R script (put these in "data output")

# 1. data frame we want to write to 
# 2. 2nd argument is the path 
write_csv(surveys_complete, path="data output/surveys_complete_dataframeTOcsv_TEST")






############################################################################# MARTHA EXIT, MICHAEL ENTER
############################################################################# get ready to be excited.   
############################################################################# GGPLOT TIME!

#### ggplottime! =====================   

# [4 pound signs] + [the text] + [any symbol a bunch of times] > CREATES A HEADER. YES!!! 

# this shows up at the bottom of the viewable open script, 
    # but you can also see it in this viewablescript screen topleft on the right of "source" 
        #  -- > shows a document outlilne! 

  #or tools, keyboard shortcuts, find that. 

#also a way to TIME STAMP   (function is "ts")
# Tue Feb 12 14:31:25 2019 ------------------------------

#### OK, next section ############################# 
#############################################################################

# ggplot(data=DATA, mapping = aes(MAPPINGS)) +
# geom_function() 

ggplot(data=surveys_complete) #pops a gray box up in your PLOTS tab. Here is your nice clean pallet 

# now define a mapping 

ggplot(data=surveys_complete, mapping=aes(x=weight, y=hindfoot_length)) #ok ggplot, go into my data and do this

#we get an empty plot, but we told the canvas what the dimensions should be. Notice that it knows the scales (range of the data) --

# now instead of a PIPE  (%>%)   do a PLUS (+) -- line has to end in this so it looks into next line 

ggplot(data=surveys_complete, mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point() #now it'll plot every point; go look at it! play with zoom. it smartly resizes for you. 
  


#############################################################################
#### saving a plot oject ==========================================================================

surveys_plot <- ggplot(data=surveys_complete, mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point() # just SAVED the canvas where you left off

surveys_plot+
  geom_point() #GEOMS know to read back to the original line that called the data. (in the same script)

#maybe you want the next GEOM POINTs .. to be a different layer .. looking at different sets of columns and paint on top of that. it can handle that! 


#############################################################################
#### Challenge (optional) -----------------------

#Scatter plots can be useful exploratory tools for small datasets. For data sets with large numbers of observations, such as the surveys_complete data set, overplotting of points can be a limitation of scatter plots. One strategy for handling such settings is to use hexagonal binning of observations. The plot space is tessellated into hexagons. Each hexagon is assigned a color based on the number of observations that fall within its boundaries. To use hexagonal binning with ggplot2, first install the R package hexbin from CRAN:

install.packages("hexbin")
library(hexbin)

surveys_plot +
  geom_hex()  #whoa! shows areas of high density points

####################################################################### BUILDING PLOTS FROM GROUND UP
#### BUILD PLOTS, GROUND UP ==================================================================


# TWO WAYS 

#1
ggplot(data=surveys_complete, mapping=aes(x=weight,y=hindfoot_length))
#2
surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length))





# add on ....

####################################################################### PLOT APPEARANCE 
#### modifying whole geom appearances  ===========================================================


# modifying whole geom appearances 
surveys_complete %>%                         # %>% here
  ggplot(aes(x=weight,y=hindfoot_length)) +  #  + here
  geom_point(alpha=0.1, color="tomato") #ALPHA (opaqueness of points (0 is clear, 1 is solid)); COLOR key in R somewhere, tomato is a real color 


####################################################################### DATA IN GEOM 
#### usng data in a geom  ===========================================================

surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length)) +
  geom_point(alpha=0.1, aes(color=species_id)) #set the color according to species ID! 

#putting color as a global AESthetic   (same output, but any GEOMS we add on will also use color) 
#### geoms dont look inside each other, each one just looks back to the ggplot line. 

surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length, color=species_id)) + #that's a global aesthetic now 
  geom_point(alpha=0.1) #set the color according to species ID! 

####################################################################### GEOM_JITTER 
#### geom_jitter  ===========================================================
#adds a little noise for each point so exact same values can't be put on top of it. 

# using a little jitter
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_jitter(alpha = 0.1)



####################################################################### BOX PLOTS
#### boxplots  ===========================================================

surveys_complete %>% 
  ggplot(aes(x=species_id,y=weight)) +
  geom_boxplot()
  
####################################################################### POINTS TO BOXPLOT
#### adding points to boxplot  ===========================================================


surveys_complete %>% 
  ggplot(aes(x=species_id,y=weight)) +
  geom_boxplot()+
  geom_jitter(alpha=0.3, color="tomato") #but the boxes are OVERLAPPED 

# SO TRY 

surveys_complete %>% 
  ggplot(aes(x=species_id,y=weight)) +
  geom_jitter(alpha=0.1, color="tomato") +  # "a whisper of points" -michael 
  geom_boxplot(alpha=0) #and extra alpha for box.  

# NOTICE. some geoms recognize "color" vs "fill" -- and color changes the outline not the fill. not there though

####################################################################### PLOTTING TIME SERIES 
#### plotting time series  ===========================================================

yearly_counts <- surveys_complete %>% 
  count(year,species_id)     #this is same as group_by yr+speciesID  & tally, all in one


yearly_counts %>% 
  ggplot(aes(x=year,y=n))+ #the thing created by that "tally" in COUNT() 
  geom_line()  #whoa, that's not what we want. we want each line to be its own color. 

#can do this with a groupy thing. 

yearly_counts %>% 
  ggplot(aes(x=year,y=n, group=species_id))+  
  geom_line() # ..mkay. which is which species ? 

yearly_counts %>% 
  ggplot(aes(x=year,y=n, group=species_id, color=species_id))+  
  geom_line() 


####################################################################### FACETTING
#### FACETTING  ===========================================================


#add a facet_wrap (giving it a grouping variable)(gives subplot for each thing in the grouping variable)
yearly_counts %>% 
  ggplot(aes(x=year,y=n))+  
  geom_line()+
  facet_wrap(~ species_id) # WHOOOOOOOA
  
yearly_counts %>% 
  ggplot(aes(x=year,y=n, color=species_id))+  
  geom_line()+
  facet_wrap(~ species_id) # WHOOOOOOOA X 2 

####################################################################### including sex
#### including sex  ===========================================================

yearly_sex_counts<- surveys_complete %>% 
  count(year,species_id,sex)

ysx_plot<- yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +  #except now sex is broken out 
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw()+    # gray background on ppt slides, people go "ooh you did that in GGPLOT". but then make it fancy and they go "ooooooh" :) 
  theme(panel.grid = element_blank())



#OK THESE DONT WORK......................
install.packages("ggthemes")
ysx_plot + ggthemes::theme_tufte   #may need new packages? // 
install.packages("MCMBasics")
ysx_plot + MCMBasics::minimal_ggplot_theme  #michael made a package with all the themes he likes

# you can also do at the top of a script "MYTHEME <-" and set a style, and apply it to a bunch of plots! slick 

####################################################################### a little more facetting
#### a little more facetting  ===========================================================

yearly_sex_weight<-surveys_complete %>% 
  group_by(year, sex, species_id) %>% 
  summarise(avg_weight = mean(weight))


#facetwrap (creates arbitrary number of dimensions (however many you have)
#facet_grid (lets you be more specific )  
    # facet_grid(rows~columns)
    # the "." indicates nothing in this dimension (period says "I just have one thing")

yearly_sex_weight %>% 
  ggplot(aes(x=year,y=avg_weight,color=species_id))+
  geom_line()+  
  facet_grid(sex~.)   #each facet will be a sex. the period says I just have one thing. (say nothing)


yearly_sex_weight %>% 
  ggplot(aes(x=year,y=avg_weight,color=species_id))+
  geom_line()+  
  facet_grid(.~sex)   #nothing faceted for rows 


####################################################################### adding labels and stuff 
#### adding labels and stuff  ===========================================================


PLOT<-yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())+
  labs(title = "Observed species through time", x = "Year of observation", y = "Number of species")+
  theme(text=element_text(size=16))+
  theme(axis.text.x = (element_text(color="grey20",size=12, angle=90, hjust=0.5,vjust=0.5)))


#advice. take a plot you make a lot. tweak it so you like it. save that code. apply it in future plots! 







#### ggsave  ===========================================================================

ggsave("figures/my_test_facet_plot.jpeg", plot=PLOT, height=8,width=8)  #without "plot =" it will just take your last plot. 

#you can also change the file end type (.pdf, .tif, .png)







#google for ggplot cheat sheet! 

#google "ggplot2 reference" -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!



# HOW TO SAVE YOUR OWN THEME 

my_theme<- theme_bw() +
  theme(panel.grid = element_blank())

ysx_plot+my_theme + theme(element.............)









