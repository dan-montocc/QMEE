# QMEE


## Assignment 1

Author: Danielle Montocchio

Date: January 22, 2021

Purpose: Assignment 1 for QMEE (708) Course

Dataset: `SpeciesData_Consol.csv`

Description: This dataset is a consolidation and overview of a larger dataset, collected by myself and past researchers in the PCF lab. The main variables collected were plant species name, and the respective water depth each species was found to be growing at in a given coastal wetland site in the Laurentian Great Lakes region. This information was used to calculate the Wetland Macrophyte Index (WMI) score of the wetland sampled. 

[For more information see: Croft, M. V., Chow-Fraser, P., 2007. Use and development of the wetland macrophyte index to detect water quality impairment in fish habitat of Great Lakes coastal marshes. J. Great Lakes Res. 33, 172–197. https://doi.org/10.3394/0380-1330(2007)33[172:UADOTW]2.0.CO;2]

Metadata for this data can be found by reading the file `Assign1_metadata.pdf`


Questions of interest: While I am hoping to perform more complex analysis with the complete dataset, which needs to digitized (once access to the appropriate files can be given in LSB); I do have some initial biological questions I would like to explore with `SpeciesData_Consol.csv`. 

Specifically, I would like to see whether Lake Huron water levels affect the total number of species present in a given wetland, as well as the number of species found in different functional/ecological groups? I predict that with increasing water levels, the number of emergent species present should decrease, while the number of submergent species should increase with increasing water levels. I also predict that the occurrence of terrestrial plant species should increase with increasing lake levels, as the meadow and high-marsh zones become inundated with water, and then become included in our dataset more due to our sampling protocols requiring all aquatic areas of a wetland to be sampled. In order to test these hypotheses, I will likely need to perform a linear regression of these variables against water level (after the assumptions of this test have been  checked for no violations.)

<!-- BMB: can you say more about the _scientific_ reasons for these questions? These are framed as statistical questions (with expected directions of effect, which is very good), but I would be curious to know why these trends matter to you ...

Avoid asking "does X affect Y?" - because the answer is almost always "yes" for any ecological system where you have bothered to measure both X and Y. "How much does X affect Y?" "In what direction does X change when Y changes?" "Can we clearly distinguish the effect of X on Y?" and "Does X affect Y enough to be important for scientific or management reasons?" are all better questions.
-->

## Assignment 2

Author: Danielle Montocchio

Date: January 29, 2021

Purpose: Assignment 2 for QMEE (708) Course

Dataset: `WMI_SpeciesAbun_PeriodGroup.csv`

Description: This dataset is a further consolidation of the WMI database, where plant species overall abundance, abundance by a given species' wetland zone functional grouping and whether it is native or exotic to the area is summed for each wetland site and which period of lake water-levels that site was sampled in. Period 1 = low-water levels; 1999-2013. Period 2 = high-water levels; 2014-2019.

[For more information see: Croft, M. V., Chow-Fraser, P., 2007. Use and development of the wetland macrophyte index to detect water quality impairment in fish habitat of Great Lakes coastal marshes. J. Great Lakes Res. 33, 172–197. https://doi.org/10.3394/0380-1330(2007)33[172:UADOTW]2.0.CO;2]


Questions of interest: While I am hoping to perform more complex analysis with the complete dataset, which needs to digitized (once access to the appropriate files can be given in LSB); I do have some initial biological questions I would like to explore with `WMI_SpeciesAbun_PeriodGroup.csv`. 

Specifically, I would like to see whether Lake Huron water levels significantly affect the total number of aquatic species present in a given wetland, as well as the number of species found in different functional/ecological groups? Since many plant species have an optimal water depth they will grow in a wetland, due to light requirements, the significant increase in Lake Huron water-levels in 2014 is theorized to alter the distribution and number of macrophyte species in a wetland. Such an alteration is likely to then impact the fish community, which depends on different plant species to meet their different ecological needs.

Of great importance is the number of submergent species available in a wetland, as these plants tend to act as nursery habitat, particularly for juvenile esocids, such as muskie.

What is unclear is whether the change in water levels will have impacted all coastal wetlands equally (or rather significantly) as their bathymetry, exposure to the lake, and level of human disturbance, all varies across Georgian Bay. It is also unknown whether the absolute number of species for a given wetland zone functional group is enough to capture the potential change in a wetland's ecological function for fish, or that a more-detailed species-specific model is required?

I predict that with increasing water levels, the number of emergent species present should decrease, while the number of submergent species should increase with increasing water levels. I also predict that the occurrence of terrestrial plant species should increase with increasing lake levels, as the meadow and high-marsh zones became inundated with water, and then became included in our dataset more due to our sampling protocols requiring all aquatic areas of a wetland to be sampled. In order to test these hypotheses, I will likely need to perform a paired t-test of these variables against water level (likely non-parametric due to sample size).

## Assignment 3

Author: Danielle Montocchio

Date: February 6, 2021

Purpose: Assignment 3 for QMEE (708) Course

I split Assignment 3 into a new R file, as there was errors in my original dataset of Assignment 2 and that script became a diagnosis and cleaning file.

Dumb-bell plot: In these plots I am trying to compare the changes in total and submergent species abundance by wetland region and site between Period 1 and 2. Since the variance is the focus for this question, that is a before and after comparison, I decided to use a dumb-bell plot. The graphing principle I used is based on the Cleveland hierarchy, that humans are best at interpreting distances along the same scale.

Treemap plot: For assessing changes in all functional plant species groups, I thought another graphing approach would be better, as it is difficult for people to discern multiple colours (I thought a dumbbell plot would be too busy). A treemap seemed to make sense as this would show the proportion of functional groups by area, rather than angles like in a pie chart, again making use of the Cleveland hierarchy. Unfortunately, I was unable to then plot the two treemaps together, so I instead joined them and made a dumbbell plot for all of Georgian Bay.

## Assignment 4

Author: Danielle Montocchio

Date: February 15, 2021

Purpose: Assignment 4 for QMEE (708) Course

Note: I felt that from past assignments, using the consolidated form of my data, I have already asked the hypotheses I was interested in with this specific dataset. Therefore, this hypothesis relates to the complete dataset collected by our lab over 20 years (see 'metadata_Assign1Data.html' for details). Once compiled, the data will have presence/absence for macrophyte species, the location they were found in a given wetland, the water depth they were found at, and can be linked to other environmental variables such as water quality parameters from a separate dataset.

Hypothesis: Considering the importance of macrophyte species presence/absence and distribution within a wetland for fish communities, our lab's dataset which not only covers a vast range of wetlands with differing geomorphology, but also across two periods of distinct water-levels, provides a unique case study that can be used to model species distributions. I would like to develop a Species Distribution Model (SDM) of macrophyte species in Georgian Bay coastal wetlands, in order to predict the presence/absence of a given species of plant, depending on differing environmental conditions, particularly water level changes. 

If successful in developing a model which effectively predicts species distributions using environmental variables, this model is then proposed to be extended to predict fish species presence/absence, based on environmental conditions and macrophyte species presence. This first step is important, as past research has shown that fish community structure seems to be more dependent on macrophyte species composition, rather than water quality (Cvetkovic et al., 2010).

Testing methodology: In order to develop this SDM, I will likely develop several models of complementary performance and then cross-validate them using separate data to establish which model best fits the goal of my study. This method has been proposed by Norberg et al. (2019), who assessed 33 variants of 15 different types of SDMs. Their founding was that, with every model, there are trade-offs in what the model is capable of predicting and accounting for ecologically, depending on the model's structure and assumptions. That being said, these researchers suggested the use of Joint Species Distribution Models (JSDM), when evaluating data that has built-in ecological function redundancy (that is not one specific species has a ecological function that no other species can provide). This characteristic applies to our data, as was determined by the first chapter of my thesis. In addition, JSDMs capture species‐to‐species associations, without necessarily assuming rigid species‐by‐species relationships, which leads to superior predictions at the community-level.

There are several possible JSDMs to choose from, which would require detailed research into each, assessing their uses and built-in assumptions. That being said, Norberg et al. (2010) did propose several, such as species archetype model (SAM), multivariate regression tree (MRTS), multivariate stochastic neural networks (MISTN), and hierarchical modeling of species communities (HMSC). All of which may be effective for my data.

The parameters I could use to evaluate these different models may include those used by Norberg et al. (2019), such as accuracy, discrimination, calibration, and precision.

JD: This is cool, and I think useful for us and for you. But there's no hypothesis here. You're essentially describing a predictive project, which is fine in general, but not a good fit for this assignment.

Grade 2.0/3


## Assignment 5

Author: Danielle Montocchio

Date: February 26, 2021

Purpose: Assignment 5 for QMEE (708) Course

Data: 'WQI_Volume_Data.csv'

Data Description: This dataset consists of the calculated volume of a given Georgian Bay coastal wetland during the time it was sampled, as well its calculated WQI (Water Quality Index) score. The WQI is an index designed to quantify the effect that human disturbance, such as agriculture and roads, can have on wetland health. Specifically, it uses the known the relationship between good water quality and the growth of submerged aquatic vegetation to establish whether a wetland is "healthy" enough to sustain suitable fish habitat. To calculate this index 12 water quality parameters, of which I have included 8 that I hypothesize may be pertinent to my analysis.

Background: Between the years of 2000-2019, Lake Huron has experienced to irregular water levels, which consists of two distinct periods. Period 1, from 2003-2013, was a sustained low-water period; Period 2, from 2014-2019, was a high-water period (0.9m high water-levels than in Period 1).

Biologically, such a change in water-levels is theorized to alter water quality, as previous studies has  found a link between water levels and water quality parameters such as turbidity and total suspended sediments (TSS)(Chow-Fraser, 1999), which are used to calculate the WQI scores. The past established relationship was that water-levels increase, TSS and turbidity decrease.

This is theorized to be due to the fact that as water-levels increase, so too does the volume of the wetland, which introduces a dilution effect to the water quality parameters that are measured as concentrations per a given volume.

Therefore, with this data, since we were able to estimate wetland volume for a given site, we can test whether this dilution effect is occurring.

Hypothesis #1: That there is a significant effect of water levels on wetland volume and WQI score, that is as water levels increase, so too should wetland volume and WQI scores.

Hypothesis #2: If the WQI is calculated using water quality parameters, such as TSS, that are measured using concentration-volume ratios, then as Georgian Bay coastal wetlands volumes increase with increasing water-levels, WQI scores should increase as well. This is because the lower the concentrations of these parameters, the higher the WQI score (considered to be better water quality).

"Traditional" statistical tests: Since the data are non-independent (that is matched essentially as a "before" (Period 1) or "after"(Period 2)) for a given wetland, I performed a paired t-test 

Permutation tests: 

1) Manually randomize the WQI score and volume assignment to period and see if this pattern is not merely created by chance.

2) Use pre-built tests in packages such as coin and exactRankTests.

Coding file: 'Assign5.R'


## Assignment 6

__Author:__ Danielle Montocchio

__Date:__ March 5, 2021

__Purpose:__ Assignment 6 for QMEE (708) Course

__Datasets:__ `WQI_Volume_Data_Grouped.csv` and `Nutrient_Data_Grouped.csv`

__R-coding File:__ `Assign6.R`

__Hypothesis:__ If the WQI is calculated using water quality parameters, such as TSS and turbidity, that are measured using concentration-volume ratios, then as Georgian Bay coastal wetlands volumes increase with increasing water-levels, turbidity and TSS should decrease with increasing volumes, leading to an increase in WQI scores with increasing volumes. This is because the lower the concentrations of these parameters, the higher the WQI score (considered to be better water quality).

JD: NIce and clear

_Turbidity regression analysis_

According to the regression equation, the opposite relationship between volume and turbidity is occurring from what was predicted; i.e. as wetland log(volume) increases so too does turbidity. What does support our predictions however, is that Period 2 turbidity concentrations are lower than Period 1. However, there is a considerable overlap in confidence intervals, as is shown in the qplot by period, as well as a general overlap in data points between periods, indicating that this difference is not significant (cannot reject the null hypothesis).

JD: I can't really agree that the Period 2 vs. Period 1 single data point supports any conclusions about turbidity

Also looking at the diagnostic plots in order of plotting by R (not order of importance), the residuals appear to follow a generally linear pattern, more so for the lower fitted values than the higher values. The normal q-q plot indicates that the data is generally normally-distributed, with the right-tail being fatter than a standard normal distribution (particularly observations 21, 23, and 45). Looking at the scale-location plot, I would say there is unequal variance due to the sharp angle in the line near the left of the plot. The variance appears to be more concentrated at the lower end of the fitted values. Finally, according to the leverage plot, there is no single observation that appears to be significantly influencing the regression.

Using the emmeans package, performing a pairwise comparison of turbidity against log(volume) between Period 1 and 2, indicates that the mean estimate of turbidity in Period 1 is 0.745 NTU greater than in Period 2, which is illustrated in the pairwise comparison plot.

_TSS regression analysis_

According to the regression equation, the relationship between volume and TSS follows what was predicted; i.e. as wetland log(volume) increases, TSS decreases. In addition to this negative relationship for both periods,Period 2 on average has lower TSS concentrations than in Period 1. However, there is a considerable overlap in confidence intervals, as is shown in the qplot by period, as well as a general overlap in data points between periods, indicating that this difference is not significant (cannot reject the null hypothesis). This is also reflected in the coefficient p-values, and the considerably low R-squared value for the overall model. 

Again looking at the diagnostic plots in order of plotting by R (not order of importance), the residuals appear to follow a generally linear pattern, more so for the lower fitted values than the higher values, as the line deeps quite a bit for the higher fitted values. The normal q-q plot indicates that the data is generally normally-distributed, until the first theoretical quantile, with the right-tail of this distribution being fatter than a standard normal distribution (although considering the robust nature of linear regressions to non-normality, this is likely acceptable). Looking at the scale-location plot, I would say there is highly unequal (non-random) variance due to the clustering of the standardized residuals at either end of the fitted values, reflected by the sharp angle in the line near the left and right of the plot (I would likely conclude a violation of the homoscedasticity assumption for this data). Finally, according to the leverage plot, there is no single observation that appears to be significantly influencing the regression.

JD: I don't think people say "first theoretical quantile"

Using the emmeans package, performing a pairwise comparison of TSS against log(volume) between Period 1 and 2, indicates that the mean estimate of TSS in Period 1 is 1.48 mg/L greater than in Period 2, which is illustrated in the pairwise comparison plot. This difference is non-significant however (therefore we cannot reject the null hypothesis in this case if we use an alpha-level of 0.05).

JD: This is technically correct, but we don't use effects plots directly for this purpose. In particular, it is possible for bars to overlap when differences are significant.

Grade: 2.2/3

## Assignment 7

__Author:__ Danielle Montocchio

__Date:__ March 12, 2021

__Purpose:__ Assignment 7 for QMEE (708) Course

__Dataset:__ `SpeciesData_Proportions.csv`

__R-script file:__ `Assign7.R`

__Variables:__ TURB = mean turbidity for that site and period; S_Prop = proportion of submergent  species out of total no. of species found; Sub = count of submergent species found

__Hypothesis:__ Since the growth of submergent aquatic vegetation is dependent on water clarity for photosynthesis, I predict that as turbidity increases, the number and/or proportion of submergent vegetation species should decrease.

__Testing:__ 

_Poisson model_

First, I built a GLM model with a poisson distribution for the total count data of submergent species against turbidity (NTU). After this model was built, I calculated the dispersion, and found the data to be highly overdispersed (~6), therefore I created a quasipoisson model to account for this overdispersion. Looking at the diagnostic plots of this model, the residuals do not appear to have a clear non-linear pattern (such as quadratic), but are heavily condensed to the left of the plot (at the low predicted values). The Q-Q plot shows that the data is reasonably normally-distributed, however there does appear to be inflation in both tails of the distribution. As for homoscedasticity, the variance appears to be more concentrated at the lower end of the predicted values, and not as random as one would like for this model. Finally, the leverage plot shows that there are certain points that appear to be leveraging the model, particularly observation 39, but perhaps not drastically (not outside of the 1 Cook's distance line). The DHARMa residual diagnostic is consistent with these observations as it found that all three test statistics of dispersion, outliers, and uniformity (KS test) are significant, indicating that this model is not suitable for this data's distribution and that the null hypothesis cannot be rejected in this case. The autocorrelation plot shows that as submergent plant species count increases, it tends to continue increasing, that is this variable is highly autocorrelated until lag 20+.

_Binomial model_

Second, I built a GLM model with a binomial distribution for the proportion of submergent species found in a given site against turbidity (NTU). Looking at the diagnostic plots of this model, the residuals do not appear to have a clear non-linear pattern (such as quadratic), but are heavily condensed to the left of the plot (at the low predicted values). The Q-Q plot shows that the data is reasonably normally-distributed, however there does appear to be very slight inflation in both tails of the distribution (likely this deviation is non-significant). As for homoscedasticity, the variance appears to be more concentrated at the lower end of the predicted values, and not as random as one would like for this model. Finally, the leverage plot shows that there are no certain points that appear to be leveraging the model. The DHARMa residual diagnostics shows that all three test statistics of dispersion, outliers, and uniformity (KS test) are significant, indicating that is model is not suitable for this data's distribution and that the null hypothesis cannot be rejected in this case. The autocorrelation plot shows that as submergent plant proportion is not significantly autocorrelated for most lags, and therefore likely not highly autocorrelated.

__Overall:__ If I were to make a judgement call, I think neither of these models are a suitable fit for this specific dataset.

## Assignment 8

Author: Danielle Montocchio

Date: March 26, 2021

Purpose: Assignment 8 for QMEE (708) Course

Dataset: `NutrientVolume_DataJoin.Rda`

Description: Continuation of assignment 6 and GLM, now using Bayesian model statistics.