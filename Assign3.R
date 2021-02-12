#Assignment 3 R-script

#Load necessary packages
library(tidyverse)
library(here)
library(dplyr)
library(ggpubr)
library(ggplot2)
library(ggalt)
library(treemap)
library(RColorBrewer)
library(grid)

#Upload dataset to R session
PeriodComp <- read.csv(here("SpeciesData_Comp_Corrected.csv"))
## BMB: try not to use hard-coded numeric values.
## janitor::remove_empty() + select _names_ of columns you want ...
TotAbun_short <- PeriodComp[c(1:55),c(1,2,3,10)]
SubAbun_short <- PeriodComp[c(1:55),c(1,2,5,12)]

## BMB: I would probably phase out these interactive summaries/checks
## at some point you should decide your data are clean ...
#check upload
summary(PeriodComp)
summary(TotAbun_short)
summary(SubAbun_short)

head(PeriodComp)
head(TotAbun_short)
head(SubAbun_short)

tail(PeriodComp)
tail(TotAbun_short)
tail(SubAbun_short)

#show variance in species abundance between Period 1 and 2
#dumbbell plot
## BMB: this might not be necessary?
TotAbun_short$Wetland.Name <- factor(TotAbun_short$Wetland.Name)

AbunDumbPlot <- ggplot(TotAbun_short, aes(x=Abun_1, xend=Abun_2, y=Wetland.Name)) + 
    geom_segment(aes(x=Abun_1, 
                   xend=Abun_2, 
                   y=Wetland.Name, 
                   yend=Wetland.Name), 
               color="#b2b2b2", size=1)+
  geom_dumbbell(color="light blue", 
                size_x=3, 
                size_xend = 3,
                colour_x="#edae52", 
                colour_xend = "#9fb059")+
  scale_y_discrete(guide = guide_axis(n.dodge = 2))+
  labs(x="Total macrophyte abundance", y="Wetland site", 
       title="Georgian Bay coastal wetlands' total macrophyte species abundance", 
       subtitle="Change from two-distinct water-levels: Period 1 vs. Period 2")+
  geom_text(color="black", size=2, hjust=-0.5,
            aes(x=Abun_1, label=Abun_1))+
  geom_text(aes(x=Abun_2, label=Abun_2), 
            color="black", size=2, hjust=1.5)

AbunDumbPlot

## BMB: can you order this by something other than alphabet?
## max, min, mean, north-to-south?
#pretty cluttered by site, plot by region instead?
#upload region coding file
Regions <- read.csv(here("WetlandSites_RegionFile.csv"))

TotAbun_short <- inner_join(TotAbun_short,Regions)
SubAbun_short <- inner_join(SubAbun_short,Regions)

#plot by region instead
TotAbun_short$Region <- factor(TotAbun_short$Region)

AbunDumbPlot2 <- ggplot(TotAbun_short, aes(x=Abun_1, xend=Abun_2, y=Region)) + 
  geom_segment(aes(x=Abun_1, 
                   xend=Abun_2, 
                   y=Region, 
                   yend=Region), 
               color="#b2b2b2", size=1)+
  geom_dumbbell(color="light blue", 
                size_x=3, 
                size_xend = 3,
                colour_x="#edae52", 
                colour_xend = "#9fb059")+
  scale_y_discrete(guide = guide_axis(n.dodge = 1))+
  labs(x="Total macrophyte abundance", y="Wetland region", 
       title="Georgian Bay coastal wetlands' total macrophyte species abundance", 
       subtitle="Change from two-distinct water-levels: Period 1 (yellow) vs. Period 2 (green)",
       caption = "Letters superimposed over points is a given wetland sites' designated ID code")+
  geom_text(color="black", size=2, hjust=-0.5,
            aes(x=Abun_1, label=Wetland.Code))+
  geom_text(aes(x=Abun_2, label=Wetland.Code), 
            color="black", size=2, hjust=1.5)

AbunDumbPlot2

## BMB: maybe x=before vs after?
## how important is it to identify individual wetlands?

#total abundance decreases in Period 2 except site GN
#this includes terrestrials as well though!
#look at just submergent species

SubAbun_short$Region <- factor(SubAbun_short$Region)

SubDumbPlot <- ggplot(SubAbun_short, aes(x=Sub_1, xend=Sub_2, y=Region)) + 
  geom_segment(aes(x=Sub_1, 
                   xend=Sub_2, 
                   y=Region, 
                   yend=Region), 
               color="#b2b2b2", size=1)+
  geom_dumbbell(color="light blue", 
                size_x=3, 
                size_xend = 3,
                colour_x="#edae52", 
                colour_xend = "#9fb059")+
  scale_y_discrete(guide = guide_axis(n.dodge = 1))+
  labs(x="Submergent macrophyte abundance", y="Wetland region", 
       title="Georgian Bay coastal wetlands' total macrophyte species abundance", 
       subtitle="Change from two-distinct water-levels: Period 1 (yellow) vs. Period 2 (green)",
       caption = "Letters superimposed over points is a given wetland sites' designated ID code")+
  geom_text(color="black", size=2, hjust=-0.5,
            aes(x=Sub_1, label=Wetland.Code))+
  geom_text(aes(x=Sub_2, label=Wetland.Code), 
            color="black", size=2, hjust=1.5)

SubDumbPlot
#this is also the case for submergent species except for a few sites

#now I am curious how the proportion of all functional groups changes between Periods
#consolidate sites to all of Georgian Bay first to make
#trends more clear
PeriodCompAll <- PeriodComp %>%
  bind_rows(summarise_all(., ~if(is.numeric(.)) sum(.) else "Total"))
tail(PeriodCompAll)

#create small dataframe for treemap plotting
#Period 1
FuncGroup <- c("Submergent","Emergent","Floating", "Terrestrial")
## BMB: PLEASE don't hard-code values!
Value <- c(1014,389,184,0)
Per1_TreeData <- data.frame(FuncGroup,Value)
print(Per1_TreeData)


Tree_Per1 <- treemap(Per1_TreeData,
                     index="FuncGroup",
                     vSize="Value",
                     type="index",
                     palette = "Set2",    # Select your color palette from the RColorBrewer presets or make your own.
                     title="Period 1",    # Customize your title
                     fontsize.title=12, 
                     fontcolor.labels= "black"
                     ) 
## BMB: this graph doesn't convey very much information (3 data values)
## ("if a picture isn't worth 1000 words, the hell with it")

#Period 2
FuncGroup2 <- c("Submergent","Emergent","Floating", "Terrestrial")
## BMB: PLEASE don't hard-code values!
Value2 <- c(254,129,32,178)
Per2_TreeData <- data.frame(FuncGroup2,Value2)
print(Per2_TreeData)

Tree_Per2 <- treemap(Per2_TreeData,
                     index="FuncGroup2",
                     vSize="Value2",
                     type="index",
                     palette = "Set2",                        # Select your color palette from the RColorBrewer presets or make your own.
                     title="Period 2",                      # Customize your title
                     fontsize.title=12, 
                     fontcolor.labels= "black"
) 

#Plot together to compare
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 2)))
print(Tree_Per1, vp = vplayout(1,1))
print(Tree_Per2, vp = vplayout(1,2))

#Issue that treemaps are not saved as an item type that can be plotted or printed
#How to save as another plot object?

## BMB: one possibility:

get_binCI <- function(x,n) {
    b <- binom.test(x, n)$conf.int
    return(tibble(lwr=b[1],upr=b[2]))
}

pc <- (PeriodComp
    %>% pivot_longer(names_to="type",values_to="count",-starts_with("Wetland"))
    %>% separate(type,c("type","period"),convert=TRUE)
    %>% group_by(period,type)
    %>% summarise(across(count,sum),.groups="drop_last") ## keep period
    %>% filter(type %in% c("Sub","Emer","Float","Terr"))
    %>% mutate(total=sum(count),prop=count/total)
    ## https://stackoverflow.com/questions/29614849/dplyrmutate-to-add-multiple-values
    %>% group_by(period,type)
    %>% do(cbind(.,get_binCI(.$count,.$total)))
    ## should use across() ?
    %>% mutate_at("type",~factor(.,levels=c("Sub","Float","Emer","Terr")))
)

library(treemapify)
(ggplot(pc,aes(fill=type,area=count))
    + geom_treemap()
    + geom_treemap_text(aes(label=type),place="center")
    + facet_wrap(~period)
)

theme_set(theme_bw())
pd <- position_dodge(width=0.25)
print(ggplot(pc,aes(x=factor(period),y=prop,colour=type)) +
      geom_point(aes(size=count),position=pd) +
      geom_linerange(aes(ymin=lwr,ymax=upr),position=pd) +
      ## trying for an "aquatic to terrestrial" colour scale (don't like the yellow)
      ## topo.colors(4) isn't much better
      scale_colour_viridis_d()
)





#combine Periods to do a dumbbell
FuncGroup <- c("Submergent","Emergent","Floating", "Terrestrial")
Value1 <- c(1014,389,184,0)
Value2 <- c(254,129,32,178)
Period <- c(1,1,1,1,2,2,2,2)
AllPer_TreeData <- data.frame(FuncGroup,Value1,Value2,Period)
print(AllPer_TreeData)

AllPer_TreeData$FuncGroup <- factor(AllPer_TreeData$FuncGroup)

AllDumbPlot <- ggplot(AllPer_TreeData, aes(x=Value1, xend=Value2, y=FuncGroup)) + 
  geom_segment(aes(x=Value1, 
                   xend=Value2, 
                   y=FuncGroup, 
                   yend=FuncGroup), 
               color="#b2b2b2", size=1)+
  geom_dumbbell(color="light blue", 
                size_x=3, 
                size_xend = 3,
                colour_x="#edae52", 
                colour_xend = "#9fb059")+
  scale_y_discrete(guide = guide_axis(n.dodge = 1))+
  labs(x="Macrophyte abundance", y="Functional group", 
       title="Georgian Bay coastal wetlands' total macrophyte species abundance", 
       subtitle="Change from two-distinct water-levels: Period 1 (yellow) vs. Period 2 (green)")+
  geom_text(color="black", size=2, hjust=-0.5,
            aes(x=Value1, label=Value1))+
  geom_text(aes(x=Value2, label=Value2), 
            color="black", size=2, hjust=1.5)

AllDumbPlot


## BMB: this is fine. Would be really good if you could process
## your data in R to get what you want rather than hard-coding totals
## gotten in some other way: ask for help doing this!
## The graphs are fine (and attractive), although I would quibble
## with a lot of the specific choices - I think you're not really
## using the Cleveland hierarchy effectively ...

## grade: 2/3
