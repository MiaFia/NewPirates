library (tidyverse)

life_all<- read_csv2('people_dutch_real.csv')
span_df <- mutate (life_a, lifespan = as.integer(deathYear)- as.integer(birthYear))%>%
  filter(1930>birthYear>1861)
avr_df <- summarise (span_df, 'avr_span'= mean(lifespan), median_span = median(lifespan))
ggplot(data=span_df)+
  aes(x=birthYear, y=lifespan)+
  geom_point()