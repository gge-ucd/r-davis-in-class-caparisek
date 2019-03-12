# Week10 - last week of R-DAVIS :( -- Spatial Data in R -- Ryan Peek

# Ryan Peek's spatial website: https://ryanpeek.github.io/mapping-in-R-workshop/ 
# R-Davis google doc: https://docs.google.com/document/d/1A7__xU5bnQMl2hC372Ovm2EIvy26sHDRj_A0V9u2OMo/edit 

## TOOLS
install.packages("sf") 
install.packages("viridis") 
install.packages("measurements") 
install.packages("mapview") 
install.packages("tmap") 
install.packages("ggspatial") 
install.packages("ggrepel") 
install.packages("ggforce")
install.packages("cowplot") 

library(sf) # reading/writing/analysis of spatial data
library(viridis) # a nice color palette
library(measurements) # for converting measurements (DMS to DD or UTM)
library(mapview) # interactive maps
library(tmap) # good mapping package mostly for static chloropleth style maps
library(ggspatial) # for adding scale bar/north arrow and basemaps
library(ggrepel) # labeling ggplot figures
library(ggforce) # amazing cool package for labeling and fussing 
library(cowplot) ## MOOOOOOO!! for plotting multiple plots

## DATA
install.packages("tigris") # ROAD/CENSU DATA, see also the "tidycensus" package
install.packages("USAboundaries") # great package for getting state/county boundaries
install.packages("sharpshootR")  # CDEC.snow.courses, CDECquery, CDECsnowQuery


library(tigris) # ROAD/CENSU DATA, see also the "tidycensus" package
library(USAboundaries) # great package for getting state/county boundaries
library(sharpshootR)  # CDEC.snow.courses, CDECquery, CDECsnowQuery















