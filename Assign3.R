#Assignment 3 R-script

#Load necessary packages
library(tidyverse)
library(here)
library(dplyr)
library(ggpubr)
library(ggplot2)
library(compare)

#Upload dataset to R session
PeriodComp <- read.csv(here("SpeciesData_Comp_Corrected.csv"))
TotAbun <- readRDS(here("SpeciesAbun_Subset_Long.rds"))
SubAbun <- readRDS(here("SpeciesSub_Subset_Long.rds"))