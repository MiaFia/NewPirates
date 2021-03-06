library (tidyverse)
library(readr)
library(ggthemes)
theme_set(theme_light(base_size = 14))
#The data for this project is taken from https://www.gapminder.org/data/ filtered for life expectency. 
#This filter could also be added manually but since the original csv is really big we decided to use this
#pre-applied filter and downloaded it as a csv.

life_expectancy_years <- read_csv("./Data/life_expectancy_years.csv")

life_expectany_SA <- life_expectancy_years%>%
  filter(country== "South Africa")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<2050)
Life_Medians_Means_SA= life_expectany_SA%>%
  summarize(median_SA= median(as.integer(Expectancy)),
            mean_SA= mean(as.integer(Expectancy)))

life_expectancy_NL <- life_expectancy_years%>%
  filter(country== "Netherlands")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<2051)


Life_medians_Means_NL= life_expectancy_NL%>%
  summarize(median_NL= median(as.integer(Expectancy)),
            mean_NL= mean(as.integer(Expectancy)))

ggplot() +
  geom_line(data= life_expectancy_NL, aes(x=as.integer(Year), y= Expectancy, colour= 'Netherlands'))+
  geom_line(data= life_expectany_SA, aes(x= as.integer(Year), y= Expectancy, colour= 'South Africa'))+
  scale_y_continuous(limits = c(0,90))+
  labs(x="Year", y= "Life Expectancy in Years at Birth",
       title = "Life Expectancy", subtitle = "in the Netherlands and South Africa in years at birth.",
       colour= NULL)
ggsave('Life_Expect_NL_SA.pdf')






