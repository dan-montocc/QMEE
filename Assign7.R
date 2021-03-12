#load in packages
library(ggplot2)
library(tidyverse)
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
#use quasipoisson model
SubPlot2 <- SubPlot0 + geom_smooth(method="glm",colour="red",formula=y~x,method.args=list(family="quasipoisson"))
plot(SubPlot2)
SubMod2 <- glm(Sub~TURB,Sub_Prop,family=quasipoisson(link="log"))
summary(SubMod2)
plot(SubMod2)

acf(residuals(SubMod2))

SubPlot3 <- update(SubMod2, family=poisson)
plot(simulateResiduals(SubPlot3))

#try with proportion of submergent plants
#binomial distribution
SubPlot4 <- ggplot(Sub_Prop, aes(TURB,S_Prop)) + geom_point()

SubPlot5 <- SubPlot4 + geom_smooth(method="glm",colour="red",formula=y~x,method.args=list(family="binomial"))
plot(SubPlot5)

SubMod3 <- glm(S_Prop ~ TURB, family = binomial,
              data = Sub_Prop)
summary(SubMod3)

print((SubMod3$deviance)/(SubMod3$df.residual))

plot(SubMod3)

SubPlot6 <- update(SubMod3, family=binomial)
plot(simulateResiduals(SubPlot6))

acf(residuals(SubMod3))

