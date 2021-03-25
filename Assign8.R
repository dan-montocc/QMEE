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


##create a Bayesian interaction model with Poisson distribution
#Log Vol = continuous 
#Period = categorical with two levels

## utility for constructing an automatically named list
named_list <- lme4:::namedList

## create list of data

NutrVolDat <- with(Nutr_Vol_Per,
                named_list(N=nrow(Nutr_Vol_Per),            ## total obs
                           nPeriod=length(levels(Period)), ## number of categories
                           Period=as.numeric(Period), ## numeric index
                           LogVol=as.numeric(LogVol),
                           LogTURB))                   ## Turbidity count


## interaction model (Log volume and Period)
VolPerMod1 <- function() {
  for (i in 1:N) {
    ## Poisson model
    logmean0[i] <- b_LogVol[LogVol[i]]       ## predicted log(counts)
    ## effect of Period
    Periodeff[i] <- b_Period[LogVol[i]]*(Period[i]-1) 
    pred[i] <- exp(logmean0[i] + Periodeff[i])
    LogTURB[i] ~ dpois(pred[i])
  }
  ## define priors in a loop
  for (i in 1:nPeriod) {
    b_LogVol[i] ~ dnorm(0,0.001)
    b_Period[i] ~ dnorm(0,0.001)
  }
  
}

VolPer_Jags <- jags(data=NutrVolDat,
           inits=NULL,
           parameters=c("b_LogVol","b_Period"),
           model.file=VolPerMod1)
tidy(VolPer_Jags, conf.int=TRUE, conf.method="quantile")


## compare with generalized linear models
VolPer_GLMod1 <- glm(LogTURB ~ LogVol*Period, data=Nutr_Vol_Per, family=poisson)
VolPer_GLMod2 <- glm(LogTURB ~ LogVol*Period-1, data=Nutr_Vol_Per, family=poisson)