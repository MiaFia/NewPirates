library(tidyverse)
library('ggthemes')

#Creating a variable for the csv file
people_dutch <- read_csv("~/Desktop/Data Analysis Class/Final_Project/NewPirates/people_dutch.csv",col_types = "ii")

#Piping the data so we could get valid entries for complete cohorts, as well as getting a 
people_dutch_new <- people_dutch %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear <= 1920)
  arrange(birthYear)

#Grouping the entries by year and calculating the mean life
people_dutch_grouped <- people_dutch_new %>%
  group_by(birthYear)%>%
  summarise(average_life = mean(lifespan))

View(people_dutch_grouped)

#Creating a graph for the average life span 
ggplot(data = people_dutch_grouped) + aes(x = birthYear, y = average_life ) + 
  geom_point() + geom_smooth(method='lm') +  labs(title = "The average life span of Dutch people with a Wikipedia entry, in the 897-1920 period (completed cohorts)") +
  ylab("Average life span per year") + xlab("Year") + geom_smooth(method='lm') + theme_hc()




