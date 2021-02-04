#Assignment 2 R-script

#Load necessary packages
library(tidyverse)
library(here)
library(car)
library(dplyr)
library(ggpubr)
library(rstatix)
library(coin)

#Upload dataset to R session
PeriodComp <- read.csv(here("WMI_SpeciesAbun_PeriodGroup.csv"))

#check read-in of dataframe
summary(PeriodComp)
head(PeriodComp)

#check wetland sites in the data - repeats of the same site with spelling error, sites missing, etc...
print(PeriodComp$Wetland.Name)

#check if functional classes add to total abundance value
TotAbun1Test <- PeriodComp$Emer.1 + PeriodComp$Float.1 + PeriodComp$Sub.1
## JD: It would be cool to do this part using mutate in dplyr

head(PeriodComp$Abun.1,10)
head(TotAbun1Test, 10)
## JD: Using "head" seems like bad practice; what if there's a mismatch later?
## Also: once you get it to match, maybe put an automatic test.
#numbers match: e.g., 
## stopifnot(identical(PeriodComp$Abun, TotAbun1Test))
## This fails; can we figure out why? Warning: identical can be tricky

#check to see if data has a normal distribution to use parametric t-tests
#Abundance for Period 1 and 2
hist(PeriodComp$Abun.1, plot=TRUE)
qqPlot(PeriodComp$Abun.1)
hist(PeriodComp$Abun.2, plot=TRUE)
qqPlot(PeriodComp$Abun.2)

#Submergent abundance for Period 1 and 2
hist(PeriodComp$Sub.1, plot=TRUE)
qqPlot(PeriodComp$Sub.1)
hist(PeriodComp$Sub.2, plot=TRUE)
qqPlot(PeriodComp$Sub.2)

## JD: What's going on with Terr.1??
#Terrestrial abundance for Period 1 and 2
hist(PeriodComp$Terr.1, plot=TRUE)
qqPlot(PeriodComp$Terr.1)
hist(PeriodComp$Terr.2, plot=TRUE)
qqPlot(PeriodComp$Terr.2)

#reasonable to use parametric for abundance and submergent, not terrestrial
#use Wilcoxon signed rank for all for easier comparison and consistency

#create subsets of data for Abundance, Submergent, Terrestrial
AbunSubset <- PeriodComp[c(1:703),c(2,5,12)]
summary(AbunSubset)
SubSubset <- PeriodComp[c(1:703),c(2,8,15)]
summary(SubSubset)
TerrSubset <- PeriodComp[c(1:703),c(2,9,16)]
summary(TerrSubset)

#gather Abundance, Submergent and Terrestrial into same column
AbunSub.long <- pivot_longer(AbunSubset, cols=!Wetland.Name, names_to="PerAbun", values_to="TotAbun")
print(AbunSub.long)
SubSub.long <- pivot_longer(SubSubset, cols=!Wetland.Name, names_to="PerSub", values_to="TotSub")
print(SubSub.long)
TerrSub.long <- pivot_longer(TerrSubset, cols=!Wetland.Name, names_to="PerTerr", values_to="TotTerr")
print(TerrSub.long)

#creating weights
AbunSub.long %>%
  group_by(PerAbun) %>%
  get_summary_stats(TotAbun, type = "median_iqr")

summary(AbunSub.long)

#box plots
# Plot weight by Period and color by Period
ggboxplot(AbunSub.long, x = "PerAbun", y = "TotAbun", 
          color = "PerAbun", palette = c("#00AFBB", "#E7B800"),
          ## order = c("Abun.1", "Abun.2"),
          ylab = "Species abundance", xlab = "Period of collection")

#running into error message for boxplot
#not sure why from looking online? Help would be appreciated!
## JD: It's not an error message, since it's making your boxplot
## It's telling you that there are 1296 NAs in your data frame: 
## you should trace them back and figure out
#### if they're supposed to be NAs (in which case you should delete them before plotting) 
#### or if they're supposed to be 0s (in which case set them to 0)
## The worst thing is if there's a mixture, so it can be important to trace.

#after which I would run boxplot analysis and Wilcoxon signed rank tests on abundance
#and submergent and terrestrial plant species

## Grade 2.1/3
