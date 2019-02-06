# Step 1: R studio script file open! 

# Step 2: install package "devtools" -- for helping develop your own package.
install.packages("devtools")

#troubleshoot??:try the line--  setdiff(dir(.libPaths()), .packages(all = TRUE))



# Step 3: run the line:    devtools::install_github("melissanjohnson/pupR") 
devtools::install_github("melissanjohnson/pupR")   
      # check console to answer, option 1-7, just pick the # associated with            "None" (no updates)
      # note: if console has a "1:" instead of ">" it's waiting for this                 answer! Click next to "1:" and click "esc", or answer with a #. 


library(pupR)
pupR()
