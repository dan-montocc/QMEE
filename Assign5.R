#load in packages
library(ggplot2)
library(tidyverse)
library(coin)
library(MASS)
library(here)

#upload data
WQI_Vol <- read.csv(here("WQI_Volume_Data.csv"))
summary(WQI_Vol)

#evaluate distributions of WQI and volume
par(mfrow=c(2,2))
hist(WQI_Vol$WQI_1)
lines(density(WQI_Vol$WQI_1), col="red")
lines(seq(10, 40, by=.5), dnorm(seq(10, 40, by=.5),
                                mean(WQI_Vol$WQI_1), sd(WQI_Vol$WQI_1)), col="blue")
hist(WQI_Vol$WQI_2)
lines(density(WQI_Vol$WQI_2), col="red")
lines(seq(10, 40, by=.5), dnorm(seq(10, 40, by=.5),
                                mean(WQI_Vol$WQI_2), sd(WQI_Vol$WQI_2)), col="blue")
hist(WQI_Vol$Volume_1)
lines(density(WQI_Vol$Volume_1), col="red")
lines(seq(10, 40, by=.5), dnorm(seq(10, 40, by=.5),
                                mean(WQI_Vol$Volume_1), sd(WQI_Vol$Volume_1)), col="blue")
hist(WQI_Vol$Volume_2)
lines(density(WQI_Vol$Volume_2), col="red")
lines(seq(10, 40, by=.5), dnorm(seq(10, 40, by=.5),
                                mean(WQI_Vol$Volume_2), sd(WQI_Vol$Volume_2)), col="blue")

#not normally distributed and small sample size
#perform paired Wilcoxon ranked test of WQI scores and volume
wilcox.test(WQI_Vol$WQI_1, WQI_Vol$WQI_2, paired=TRUE)
wilcox.test(WQI_Vol$Volume_1,WQI_Vol$Volume_2,paired = TRUE)

#manual permutation
WQI_diff_obs <- mean(WQI_Vol$WQI_1) - mean(WQI_Vol$WQI_2)
WQI_difference <- WQI_Vol$WQI_1 - WQI_Vol$WQI_2  #Use that order to keep most diff. positive

nreps <- 10000
set.seed(1086)
resampMeanDiff <- numeric(nreps)
for (i in 1:nreps) {
  signs <- sample( c(1,-1),length(WQI_difference), replace = T)
  resamp <- WQI_difference * signs
  resampMeanDiff[i] <- mean(resamp)
}
WQI_diff_obs <- abs(WQI_diff_obs)
highprob <- length(resampMeanDiff[resampMeanDiff >= WQI_diff_obs])/nreps
lowprob <- length(WQI_Vol$resampMeanDiff[WQI_Vol$resampMeanDiff <= (-1)*WQI_Vol$WQI_diff_obs])/nreps
prob2tailed <- lowprob + highprob
cat("The probability from the sampling statistics is = ",prob2tailed,'\n')

par(mfrow=c(1,1))
hist(resampMeanDiff, breaks = 30, main = "Distribution of Mean Differences",
     xlab = "Mean Difference", freq = FALSE)
text(0.3,2,"Difference observed")
text(0.3,1.8,round(WQI_diff_obs,2))
arrows(0.3, 1.7, WQI_diff_obs, 0, length = .125)
text(-0.4,2,"p-value")
text(-0.4,1.8, prob2tailed)

# Compare to Student's t
tvalue <- t.test(WQI_Vol$WQI_1, WQI_Vol$WQI_2, paired = T)$statistic

cat("The t value from a standard matched-pairs t test is= ",tvalue, '\n')

#another way to do this online I found
nreps <- 99999
WQI_difference <- WQI_Vol$WQI_1- WQI_Vol$WQI_2
m0 <- mean(WQI_difference)

# perform a one-sample randomization test on WQI difference (d)
# for the null hypothesis H0: mu_d = 0   vs H1 mu_d != 0  (i.e. two tailed)
# here the test statistic is the mean
rndmdist <- replicate(nreps,mean((rbinom(length(WQI_difference),1,.5)*2-1)*WQI_difference))

# two tailed p-value:
sum( abs(rndmdist) >= abs(m0))/length(rndmdist)


#using built-in package code from coin
##oneway_test(WQI_2 ~ WQI_1 | pairs, WQI_Vol, distribution=approximate(nreps=9999))

#error: issue with data structure perhaps?
#Upload data with period grouping variable
##WQI_Vol_Grouped <- read.csv(here("WQI_Volume_Data_Grouped.csv"))
##oneway_test(WQI ~ Period | pairs, WQI_Vol_Grouped, distribution=approximate(nreps=9999))

#not sure how to resolve issue
#try a different function
library(exactRankTests)          # for perm.test()
DV <- c(WQI_Vol$WQI_1,WQI_Vol$WQI_2)
IV<- factor(rep(c("low","high"), c(length(WQI_Vol$WQI_1),length(WQI_Vol$WQI_2))))
perm.test(DV ~ IV, paired=TRUE, alternative="two.sided", exact=TRUE)$p.value


#repeat for volume
#manual permutation
Vol_diff_obs <- mean(WQI_Vol$Volume_1) - mean(WQI_Vol$Volume_2)
Vol_difference <- WQI_Vol$Volume_1 - WQI_Vol$Volume_2  #Use that order to keep most diff. positive

nreps <- 10000
set.seed(1086)
resampMeanDiff2 <- numeric(nreps)
for (i in 1:nreps) {
  signs <- sample( c(1,-1),length(Vol_difference), replace = T)
  resamp <- Vol_difference * signs
  resampMeanDiff2[i] <- mean(resamp)
}
Vol_diff_obs <- abs(Vol_diff_obs)
highprob <- length(resampMeanDiff2[resampMeanDiff2 >= Vol_diff_obs])/nreps
lowprob <- length(WQI_Vol$resampMeanDiff2[WQI_Vol$resampMeanDiff2 <= (-1)*WQI_Vol$Vol_diff_obs])/nreps
prob2tailed <- lowprob + highprob
cat("The probability from the sampling statistics is = ",prob2tailed,'\n')

hist(resampMeanDiff2, breaks = 30, main = "Distribution of Mean Differences",
     xlab = "Mean Difference", freq = FALSE)
text(50000,0.00001,"Difference observed")
text(50000,0.000009,round(Vol_diff_obs,2))
arrows(50000, 0.000008, Vol_diff_obs, 0, length = .125)
text(-50000,0.00001,"p-value")
text(-50000,0.000008, prob2tailed)

# Compare to Student's t
tvalue <- t.test(WQI_Vol$Volume_1, WQI_Vol$Volume_2, paired = T)$statistic

cat("The t value from a standard matched-pairs t test is= ",tvalue, '\n')

nreps <- 99999
Vol_difference <- WQI_Vol$Volume_1- WQI_Vol$Volume_2
m0 <- mean(Vol_difference)

# perform a one-sample randomization test on Volume difference (d)
# for the null hypothesis H0: mu_d = 0   vs H1 mu_d != 0  (i.e. two tailed)
# here the test statistic is the mean
rndmdist <- replicate(nreps,mean((rbinom(length(Vol_difference),1,.5)*2-1)*Vol_difference))

# two tailed p-value:
sum( abs(rndmdist) >= abs(m0))/length(rndmdist)

#with function
DV2 <- c(WQI_Vol$Volume_1,WQI_Vol$Volume_2)
IV2 <- factor(rep(c("low","high"), c(length(WQI_Vol$Volume_1),length(WQI_Vol$Volume_2))))
perm.test(DV2 ~ IV2, paired=TRUE, alternative="two.sided", exact=TRUE)$p.value
