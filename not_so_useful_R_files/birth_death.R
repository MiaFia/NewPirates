library (tidyverse)

#To get the mean life expectancy we do this stuff here
people_dutch <- read_csv("people_dutch_real.csv",col_types = "ii")
people_dutch_new <- people_dutch %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear >=1800)
dutch_sum<-summarise(people_dutch_new, avr_span= mean(lifespan))



#And the same for South Africans
people_SA <- read_csv("people_SA_real.csv",col_types = "ii")
people_SA_new <- people_SA %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear >=1800)
SA_sum<-summarise(people_SA_new, avr_span= mean(lifespan))