##loading in packages
library("here")
library("readr")
library("tidyverse")
library("R2jags")
library("R2WinBUGS")
library("coda")
library("emdbook")
library("dotwhisker")
library("broom.mixed")
library("rjags")
library("ggplot2"); theme_set(theme_bw())

#upload data
Nutr_Vol_Per <- (readRDS(here("NutrientVolume_DataJoin.Rda"))
  %>% mutate(Period=factor(Period,levels=c("1","2")))
  %>% mutate_if(is.character,factor)
)


##create a Bayesian interaction model with normal distribution
#Log Vol = continuous 
#Period = categorical with two levels

## utility for constructing an automatically named list
named_list <- lme4:::namedList

## create list of data
TURBdat <- with(Nutr_Vol_Per,
                named_list(N=nrow(Nutr_Vol_Per),            ## total obs
                           Period=length(levels(Period)), ## number of categories
                           LogVol=as.numeric(LogVol),      ## numeric index
                           LogTURB))  

#create bugs model
TURBmodel <- function() {
  for (i in 1:N) {
    LogTURB[i] ~ dnorm(pred[i], tau)
    pred[i] <- intercept[Period[i]] + b_LogVol[Period[i]]*LogVol[i]
    prec[i] <- tau
  }
  b_LogVol ~ dnorm(0, 0.0001)
  intercept ~ dbinom()##unsure of what parameters to put in here
  tau ~ dgamma(.001, .001)
}


#create Bayesian model
TURBbayesmod <- jags(model.file= TURBmodel
                          , parameters=c("b_LogVol", "tau", "intercept")
                          , data = TURBdat
                          #, nchains=4
                          , inits=NULL
)
tidy(TURBbayesmod, conf.int=TRUE, conf.method="quantile")
##runtime error return to fix

print(TURBbayesmod)
plot(TURBbayesmod)
traceplot(TURBbayesmod)


## compare with linear models
VolPer_Mod1 <- lm(LogTURB ~ LogVol*Period, data=Nutr_Vol_Per)
plot(VolPer_Mod1)

summary(VolPer_Mod1)

qplot(x = LogVol, y = LogTURB, data = Nutr_Vol_Per, color = Period) +
  geom_smooth(method = "lm")

##looking at Volume effect on TSS by Period
Nutr_Vol_Per$LogTSS <- log10(Nutr_Vol_Per$TSS)


#linear regressions
VolPer_Mod2 <- lm(LogTSS ~ LogVol*Period, data=Nutr_Vol_Per)
plot(VolPer_Mod2)

summary(VolPer_Mod2)

qplot(x = LogVol, y = LogTSS, data = Nutr_Vol_Per, color = Period) +
  geom_smooth(method = "lm")

