#load in packages
library(ggplot2)
library(tidyverse)
library(coin)
library(MASS)
library(here)
library(emmeans)
library(dbplyr)

#upload data sets
WQI_Vol_Per <- read.csv(here("WQI_Volume_Data_Grouped.csv"))
summary(WQI_Vol_Per)

Nutr_Per <- read.csv(here("Nutrient_Data_Grouped.csv"))
summary(Nutr_Per)

#join nutrient data with volume data
Nutr_Vol_Per <- inner_join(WQI_Vol_Per,Nutr_Per)

#log volume to be on an easier scale to read/compare
Nutr_Vol_Per$LogVol <- log10(Nutr_Vol_Per$Volume)

#check period class type
class(Nutr_Vol_Per$Period)
#change to factor
Nutr_Vol_Per$Period <- factor(Nutr_Vol_Per$Period)
#check again
class(Nutr_Vol_Per$Period)
levels(Nutr_Vol_Per$Period)

#create regression of turbidity (TURB) against volume and period
TurbVolMod <- lm(TURB ~ LogVol + Period, data = Nutr_Vol_Per)
summary(TurbVolMod)

qplot(data=Nutr_Vol_Per,x=LogVol,y=TURB, color=Period) + 
  geom_smooth(method="lm")
  
#diagnostics
plot(TurbVolMod)

#pairwise comparisons
TurbPerContrast <- emmeans(TurbVolMod, "Period")
pairs(TurbPerContrast)
plot(TurbPerContrast, xlab="TURB Mean")


#repeat with total suspended sediments (TSS)
TSSVolMod <- lm(TSS ~ LogVol + Period, data = Nutr_Vol_Per)
summary(TSSVolMod)

qplot(data=Nutr_Vol_Per,x=LogVol,y=TSS, color=Period) + 
  geom_smooth(method="lm")

#diagnostics
plot(TSSVolMod)

#pairwise comparisons
TSSPerContrast <- emmeans(TSSVolMod, "Period")
pairs(TSSPerContrast)
plot(TSSPerContrast, xlab="TSS Mean")


#save joined dataset for future use
saveRDS(Nutr_Vol_Per, file="NutrientVolume_DataJoin.Rda")
