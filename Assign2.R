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
head(PeriodComp$Abun.1,10)
head(TotAbun1Test, 10)
#numbers match

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

#box plots
# Plot weight by Period and color by Period
ggboxplot(AbunSub.long, x = "PerAbun", y = "TotAbun", 
          color = "PerAbun", palette = c("#00AFBB", "#E7B800"),
          order = c("Abun.1", "Abun.2"),
          ylab = "Species abundance", xlab = "Period of collection")

#running into error message for boxplot
#not sure why from looking online? Help would be appreciated!

#after which I would run boxplot analysis and Wilcoxon signed rank tests on abundance
#and submergent and terrestrial plant species