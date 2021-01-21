library(tidyverse)
people_dutch <- read_csv("people_dutch_real.csv",col_types = "ii")

#Piping the data so we could get valid entries for complete cohorts, as well as getting a 
people_dutch_new <- people_dutch %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear <= 1931)%>%
  arrange(birthYear)

#Grouping the entries by year and calculating the mean life
people_dutch_grouped <- people_dutch_new %>%
  group_by(birthYear)%>%
  summarise(average_life = mean(lifespan))

#And the same for South Africa
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

#And we now graph both on the same axis to get a comparison!
ggplot(data=people_dutch_grouped)+
  geom_point(data=people_dutch_grouped, aes(x = birthYear, y = average_life, color='Netherlands' ))+
  geom_smooth(data=people_dutch_grouped, aes(x = birthYear, y = average_life, color='Netherlands' ), method='lm')+
  geom_point(data=people_SA_grouped, aes(x = birthYear, y = average_life, color='South Africa' ))+
  geom_smooth(data=people_SA_grouped, aes(x = birthYear, y = average_life, color='South Africa' ), method='lm')+
  labs(title = 'Life Span in the Netherlands and South Africa',
         subtitle ='Average lifespans of people with a Wikipedia page from the Netherlands and South Africa',
         x= 'Birth Year',
         y= 'Life span in Years',
       color= 'Countries',
       source= 'Source: DPedia')+
  scale_x_continuous(breaks= c(800, 1000, 1200, 1400, 1600, 1800, 2000))+
  theme_light(base_size=14)