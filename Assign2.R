#Assignment 2 R-script

#Load necessary packages
library(tidyverse)
library(here)
library(car)
library(dplyr)
library(ggpubr)
library(rstatix)
library(coin)
library(janitor)
library(compare)

#Upload dataset to R session
PeriodComp <- read.csv(here("WMI_SpeciesAbun_PeriodGroup.csv"))

#check read-in of dataframe
summary(PeriodComp)
head(PeriodComp)

#check wetland sites in the data - repeats of the same site with spelling error, sites missing, etc...
print(PeriodComp$Wetland.Name)

#check if functional classes add to total abundance value
PeriodComp <- (PeriodComp %>% mutate(AbunCheck1 = PeriodComp$Emer.1 + PeriodComp$Float.1 + PeriodComp$Sub.1))

#same with native and exotic (try Period 2 for another check)
PeriodComp <- (PeriodComp %>% mutate(AbunCheck2 = PeriodComp$Native.2 + PeriodComp$Exotic.2))

all(PeriodComp$Abun.1 == PeriodComp$AbunCheck1)
compare(PeriodComp$Abun.1, PeriodComp$AbunCheck1, ignoreNames = TRUE, coerce = TRUE)

#both return false?
#different classes perhaps?
sapply(PeriodComp, class)

#no? check where differences are exactly
which(PeriodComp$Abun.1 != PeriodComp$AbunCheck1, arr.ind=TRUE)

#there is a difference in 8 rows! Go back to original data csv to see where error came from...
##DM: Thank you Jonathan for the more accurate check :)


#remove old dataframe first
rm(PeriodComp)

#Upload corrected csv file "SpeciesData_Comp_Corrected.csv"
#. replaced with underscore Period 1 or 2
#Nat = native, Exo = exotic
PeriodComp <- read.csv(here("SpeciesData_Comp_Corrected.csv"))

#check if functional classes add to total abundance value
PeriodComp <- (PeriodComp %>% mutate(AbunCheck1 = PeriodComp$Emer_1 + PeriodComp$Float_1 + PeriodComp$Sub_1))
all(PeriodComp$Abun_1 == PeriodComp$AbunCheck1)

PeriodComp <- (PeriodComp %>% mutate(AbunCheck2 = PeriodComp$Nat_2 + PeriodComp$Exo_2))
all(PeriodComp$Abun_2 == PeriodComp$AbunCheck2)

#check to see if data has a normal distribution to use parametric t-tests
#Abundance for Period 1 and 2
hist(PeriodComp$Abun_1, plot=TRUE)
qqPlot(PeriodComp$Abun_1)
hist(PeriodComp$Abun_2, plot=TRUE)
qqPlot(PeriodComp$Abun_2)

#Submergent abundance for Period 1 and 2
hist(PeriodComp$Sub_1, plot=TRUE)
qqPlot(PeriodComp$Sub_1)
hist(PeriodComp$Sub_2, plot=TRUE)
qqPlot(PeriodComp$Sub_2)

## JD: What's going on with Terr_1??
# DM: No terrestrial plants were sampled in Period 1 (low water) - not informative then !Remove!
#Terrestrial abundance for Period 1 and 2
hist(PeriodComp$Terr_1, plot=TRUE)
qqPlot(PeriodComp$Terr_1)
hist(PeriodComp$Terr_2, plot=TRUE)
qqPlot(PeriodComp$Terr_2)

#reasonable to use parametric for abundance and submergent, not terrestrial
#use Wilcoxon signed rank for all for easier comparison and consistency

#create subsets of data for Abundance, Submergent
#determining column number of variables for extraction
match("Abun_1", names(PeriodComp))
match("Abun_2", names(PeriodComp))
AbunSubset <- PeriodComp[c(1:703),c(2,3,10)]
summary(AbunSubset)

match("Sub_1", names(PeriodComp))
match("Sub_2", names(PeriodComp))
SubSubset <- PeriodComp[c(1:703),c(2,5,12)]
summary(SubSubset)

#gather Abundance, Submergent and Terrestrial into same column
AbunSub.long <- pivot_longer(AbunSubset, cols=!Wetland.Name, names_to="PerAbun", values_to="TotAbun")
print(AbunSub.long)
SubSub.long <- pivot_longer(SubSubset, cols=!Wetland.Name, names_to="PerSub", values_to="TotSub")
print(SubSub.long)

#creating weights
AbunSub.long %>%
  group_by(PerAbun) %>%
  get_summary_stats(TotAbun, type = "median_iqr")

summary(AbunSub.long)

#box plots
# Plot weight by Period and color by Period
ggboxplot(AbunSub.long, x = "PerAbun", y = "TotAbun", 
          color = "PerAbun", palette = c("#00AFBB", "#E7B800"),
          ## order = c("Abun_1", "Abun_2"),
          ylab = "Species abundance", xlab = "Period of collection")

#NA's - determine source
sapply(AbunSub.long, function(x) sum(is.na(x)))
#clean dataframe
AbunSub.long <- AbunSub.long[c(1:110),c(1:3)]
#check
sapply(AbunSub.long, function(x) sum(is.na(x)))
