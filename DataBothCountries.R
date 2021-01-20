library (tidyverse)
library(readr)
#The data for this project is taken from https://www.gapminder.org/data/ filtered for life expectency. 
#This filter could also be added manually but since the original csv is really big we decided to use this
#pre-applied filter and downloaded it as a csv.

life_expectancy_years <- read_csv("life_expectancy_years.csv")

life_expectany_SA <- life_expectancy_years%>%
  filter(country== "South Africa")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<1931)%>%
  summarize(median_SA= median(as.integer(Expectancy)),
            mean_SA= mean(as.integer(Expectancy)))

life_expectancy_NL <- life_expectancy_years%>%
  filter(country== "Netherlands")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<2017)%>%
  summarize(median_NL= median(as.integer(Expectancy)),
            mean_NL= mean(as.integer(Expectancy)))