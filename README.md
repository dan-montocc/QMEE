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
