#Assignment 1 R-script

#Load necessary packages
library(tidyverse)
library(broom)
library(dplyr)
library(ggfortify)
theme_set(theme_classic())

#Upload dataset to R session

# BMB: NOT REPRODUCIBLE! Please use a relative path
SpeciesData_Consol <- read.csv("SpeciesData_Consol.csv")

# BMB: attach() is strongly DISrecommended; use the data= argument
# instead
## attach(SpeciesData_Consol)
head(SpeciesData_Consol)

#Create regression model of Abun against Water Level= AbunMod
AbunMod <- lm (Abun ~ Water.Level, data=SpeciesData_Consol)
AbunMod
summary(AbunMod)
#results sig but not very informative (very low R^2)

#Testing predictions 
#Does sub incr. with water level?
SubMod <- lm(Sub ~ Water.Level, data=SpeciesData_Consol)
summary(SubMod)
#n.s. and not informative

#Does terr incr. with water level?
TerrMod <- lm(Terr ~ Water.Level, data=SpeciesData_Consol)
summary(TerrMod)
#follows expected trend and sig, R^2 low

# BMB: collapsing to a single mutate() call
#What about the proportion of terr to non?
#Create new variables - nonterrestrial species total and proportion
SpeciesData_Consol <- SpeciesData_Consol %>%
    mutate(NonTerr = Sub+Float+Emer,
           TerrProp = Terr/NonTerr)

## BMB: avoid 'interactive' commands in scripts
##View(SpeciesData_Consol) #check variable calculation

PropMod <- lm(TerrProp ~ Water.Level, SpeciesData_Consol)
# detach(SpeciesData_Consol)
# attach(SpeciesData_Consol)
summary(PropMod)

#check linear regression assumptions
op <- par(mfrow = c(2,2))
plot(PropMod)
#linear regression fit is not ideal - may be better to run paired t-test by wetland (lump water levels into low and high categories)
par(op) ## restore original graphics settings

# BMB: this is presumably caused by a preponderance of zeros in your data

plot(table(SpeciesData_Consol$TerrProp))
hist(SpeciesData_Consol$TerrProp,col="gray")

## BMB: I agree that this is challenging. There are a few different ways
## to deal with it (two-stage or 'hurdle' model, censored regression/tobit model, use permutation tests to get robust p-values), we can discuss it.

## also: want to consider analyses that take characteristics of data
## (proportions? multinomial? multivariate?)
