#load in packages
library(ggplot2)
library(tidyverse)
library(here)
library(coin)
library(lmPerm)

#upload data
WQI_Vol <- read.csv(here("WQI_Volume_Data.csv"))
print(WQI_Vol)
summary(WQI_Vol)