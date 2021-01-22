#Code for South Africa
library(tidyverse)
library(readr)
library('ggthemes')

life_expectancy_years <- read_csv("./Data/life_expectancy_years.csv")

life_expectancy_SA <- life_expectancy_years%>%
  filter(country== "South Africa")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<1931)

people_SA <- read_csv("people_SA_real.csv",col_types = "ii")

#Piping the data so we could get valid entries for complete cohorts, as well as getting a 
people_SA_new <- people_SA %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear <= 1931)%>%
  arrange(birthYear)

#Grouping the entries by year and calculating the mean life
people_SA_grouped <- people_SA_new %>%
  group_by(birthYear)%>%
  summarise(average_life = mean(lifespan))


#Creating a graph for the average life span and the life expectancy for South Africa
ggplot(data = people_SA_grouped)+ 
  geom_line( aes(x = birthYear, y = average_life, color='Lifespan DBpedia' ), size =0.5) + 
  geom_smooth(data= people_SA_grouped, aes(x = birthYear, y = average_life, color='Lifespan DBpedia'),size=1.5,method='lm') +
  geom_line(data=life_expectancy_SA, aes(x=(as.integer(Year)), y=Expectancy, color= 'Life Expectancy Gapminder'))+
  labs(title = "Lifespan and Life expectancy for South Africa",
       subtitle= 'Lifespan of well-known South African people compared to 
       the average life expectancy taken from Gapminder',
       x="Birth Year",
       y= "Average Lifetime",
       colour= 'Source') +
  theme_light(base_size = 16)+
  scale_y_continuous(limits = c(0,90))+
  scale_x_continuous(limits=c(1800, 1930))