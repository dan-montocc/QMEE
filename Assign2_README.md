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