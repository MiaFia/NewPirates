library(tidyverse)
library(readr)
library('ggthemes')
Sys.setenv(LANG= "en")
ibrary (tidyverse)
library(readr)
#The data for this project is taken from https://www.gapminder.org/data/ filtered for life expectancy. 
#This filter could also be added manually but since the original csv is really big we decided to use this
#pre-applied filter and downloaded it as a csv.

life_expectancy_years <- read_csv("life_expectancy_years.csv")

life_expectancy_SA <- life_expectancy_years%>%
  filter(country== "South Africa")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<1931)

life_expectancy_NL <- life_expectancy_years%>%
  filter(country== "Netherlands")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<1931)

#Then we find the dutch peopel
library('ggthemes')

#Creating a variable for the csv file
people_dutch <- read_csv("people_dutch_real.csv",col_types = "ii")

#Piping the data so we could get valid entries for complete cohorts, as well as getting a 
people_dutch_new <- people_dutch %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear <= 1931)
arrange(birthYear)

#Grouping the entries by year and calculating the mean life
people_dutch_grouped <- people_dutch_new %>%
  group_by(birthYear)%>%
  summarise(average_life = mean(lifespan))

View(people_dutch_grouped)

#Creating a graph for the average life span and the life expectancy for Netherlands 
ggplot(data = people_dutch_grouped)+ geom_point( aes(x = birthYear, y = average_life )) + geom_point(data=life_expectancy_NL, aes(x=(as.integer(Year)), y=Expectancy), color= 'red')+
  labs(title = "Average life spand and life expectancy in Netherlands",
       subtitle= 'The average life span of Dutch people with a Wikipedia entry, in the 897-1920 period (completed cohorts)') +
  ylab("Average life span per year") + xlab("Year") +theme_hc()+geom_smooth(data= people_dutch_grouped, aes(x = birthYear, y = average_life),method='lm') +
  geom_smooth(data= life_expectancy_NL,aes(x=(as.integer(Year)), y=Expectancy), color= 'red' ,method='lm')+
  scale_y_continuous(limits = c(0,90))



  
#Then we can run the whole thing for South Africa too!
people_SA <- read_csv("people_SA_real.csv",col_types = "ii")

#Piping the data so we could get valid entries for complete cohorts, as well as getting a 
people_SA_new <- people_SA %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear <= 1931)
arrange(birthYear)

#Grouping the entries by year and calculating the mean life
people_SA_grouped <- people_dutch_new %>%
  group_by(birthYear)%>%
  summarise(average_life = mean(lifespan))

View(people_SA_grouped)

#Creating a graph for the average life span and the life expectancy for Netherlands 
ggplot(data = people_SA_grouped)+ geom_point( aes(x = birthYear, y = average_life )) + geom_point(data=life_expectancy_SA, aes(x=(as.integer(Year)), y=Expectancy), color= 'red')+
  labs(title = "Life span and Life expectancy for South Africa",
       subtitle= 'The average life span on People from South Africa with a Wikipedia entry in the period 897-1931(completed cohorts) and the life expectancy between 1800-1931') +
  ylab("Average life span per year") + xlab("Year") +theme_hc()+geom_smooth(data= people_SA_grouped, aes(x = birthYear, y = average_life),method='lm') +
  geom_smooth(data= life_expectancy_SA,aes(x=(as.integer(Year)), y=Expectancy), color= 'red' ,method='lm')+
  scale_y_continuous(limits = c(0,90))