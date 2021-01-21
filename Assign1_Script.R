#Assignment 1 R-script

#Load necessary packages
library(tidyverse)
library(broom)
library(dplyr)
library(ggfortify)
theme_set(theme_classic())

#Upload dataset to R session
SpeciesData_Consol <- read.csv("C:/Users/dan_g/OneDrive/School/University/Graduate Studies/Grad Courses/QMEE (708)/QMEE_Directory/QMEE-journey/QMEE-journey/SpeciesData_Consol.csv")
attach(SpeciesData_Consol)
head(SpeciesData_Consol)

#Create regression model of Abun against Water Level= AbunMod
AbunMod <- lm (Abun ~ Water.Level)
AbunMod
summary(AbunMod)
#results sig but not very informative (very low R^2)

#Testing predictions 
#Does sub incr. with water level?
SubMod <- lm(Sub ~ Water.Level)
summary(SubMod)
#n.s. and not informative

#Does terr incr. with water level?
TerrMod <- lm(Terr ~ Water.Level)
summary(TerrMod)
#follows expected trend and sig, R^2 low

#What about the proportion of terr to non?
#Create new variables - nonterrestrial species total and proportion
SpeciesData_Consol <- SpeciesData_Consol %>% mutate(NonTerr = Sub+Float+Emer)
SpeciesData_Consol <- SpeciesData_Consol %>% mutate(TerrProp = Terr/NonTerr)
View(SpeciesData_Consol) #check variable calculation

PropMod <- lm(TerrProp ~ Water.Level, SpeciesData_Consol)
detach(SpeciesData_Consol)
attach(SpeciesData_Consol)
summary(PropMod)

#check linear regression assumptions
par(mfrow = c(2,2))
plot(PropMod)
#linear regression fit is not ideal - may be better to run paired t-test by wetland (lump water levels into low and high categories)