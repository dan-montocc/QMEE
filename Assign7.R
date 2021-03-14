#load in packages
library(ggplot2) ## redundant with tidyverse
library(tidyverse)  
## BMB: what do we need coin for? Avoid loading unnecessary packages ...
library(coin)
library(MASS)
library(here)
library(DHARMa)

#upload data
Sub_Prop <- read.csv(here("SpeciesData_Proportions.csv"))
summary(Sub_Prop)

#count data so poisson regression
# no. of submergent plant species present based on turbidity
SubPlot0 <- ggplot(Sub_Prop, aes(TURB,Sub)) + geom_point()

SubPlot1 <- SubPlot0 + geom_smooth(method="glm",colour="red",formula=y~x,method.args=list(family="poisson"))
plot(SubPlot1)
SubMod1 <- glm(Sub~TURB,Sub_Prop,family=poisson(link="log"))
summary(SubMod1)

#checking for overdispersion
print((SubMod1$deviance)/(SubMod1$df.residual))

#very overdispersed
## BMB: might want to check diagnostics etc. FIRST; overdispersion can
##  be driven by problems with the model (outliers, nonlinearity ...)
#use quasipoisson model
SubPlot2 <- SubPlot0 + geom_smooth(method="glm",colour="red",formula=y~x,method.args=list(family="quasipoisson"))
plot(SubPlot2)
SubMod2 <- glm(Sub~TURB,Sub_Prop,family=quasipoisson(link="log"))
summary(SubMod2)
plot(SubMod2)
## BMB: this is interesting. The tails are too *light* here (missing
##  extreme values)
## BMB: might want to check the three extreme values (high Turbidity)

## BMB: acf only makes sense when you have a time series
acf(residuals(SubMod2))

SubPlot3 <- update(SubMod2, family=poisson)
plot(simulateResiduals(SubPlot3))
## BMB: woah!
## if you want to use DHARMa but have overdispersion you should use
## MASS::glmer.nb or glmmTMB to fit a negative binomial model ...

#try with proportion of submergent plants
#binomial distribution
SubPlot4 <- ggplot(Sub_Prop, aes(TURB,S_Prop)) + geom_point()

## BMB: need to specify weight (also, maybe quasibinomial)
SubPlot5 <- SubPlot4 + geom_smooth(method="glm",colour="red",formula=y~x,
                                   aes(weight=Abun),
                                   method.args=list(family="quasibinomial"))
plot(SubPlot5)
## 

## BMB: you're ignoring an important warning message!
SubMod3 <- glm(S_Prop ~ TURB, family = binomial,
               weights=Abun,
              data = Sub_Prop)
summary(SubMod3)

print((SubMod3$deviance)/(SubMod3$df.residual))

plot(SubMod3)
## BMB: this looks better than count model
## (takes total abundance into account)

## BMB: what is this doing? wasn't it already binomial?
SubPlot6 <- update(SubMod3, family=binomial)
plot(simulateResiduals(SubPlot6))

## BMB: see comment above
acf(residuals(SubMod3))

## grade: 1.9
## when you see warnings you should either (1) fix the code to make them
## go away, (2) comment on why they're occurring and why they can be ignored,
## (3) if all else fails, comment that you are seeing warnings and don't
## understand them. (Ideally, ask for help resolving/understanding errors
## before submitting HW)
