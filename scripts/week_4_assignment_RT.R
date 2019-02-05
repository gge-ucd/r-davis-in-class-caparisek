week_4_assignment_RT

download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv")

# Read Portal
surveys <- read.csv("data/portal_data_joined.csv")

#Subset data into surveys_subset

surveys_subset <- surveys[1:400, c (1,5:8)]


# Challenge Portion- Select all rows that have a hindfoot_length greater than 32, save these in a new data.frame named  surveys_long_feet

subset(surveys_subset,hindfoot_length>32)
surveys_long_feet <- subset(surveys_subset,hindfoot_length>32)

# Create a Histogram
hist(surveys_long_feet$hindfoot_length)

# Change hind_footlenghts to character vectors

as.character(surveys_long_feet$hindfoot_length)

# Create histogram of the characters

hist(as.character(surveys_long_feet$hindfoot_length ))
# Error in histogram --> must be numeric. Histograms calculate a distribution from numeric values and we just turned ours into character values