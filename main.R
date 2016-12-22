
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(zoo)
# library(ggplot2)
library(plyr)
library(leaps)
library(MASS)
library(partykit)

source("input.R",encoding = "UTF8")

source("darzeliu_grupes.R",encoding = "UTF8")

# source("datachecks.R",encoding = "UTF8")
# 
# source("visuals1.R",encoding = "UTF8")
# 
# source("kysiai.R",encoding = "UTF8")
# 
# source("tree.R",encoding = "UTF8")