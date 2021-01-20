library (tidyverse)

life_all<- read_csv2('people_dutch_real.csv')
span_df <- mutate (life_all, lifespan = as.integer(deathYear)- as.integer(birthYear))%>%
  filter(1920>birthYear>1861)
avr_df <- summarise (span_df, 'avr_span'= mean(lifespan))