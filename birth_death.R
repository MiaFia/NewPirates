library (tidyverse)

NLlife_all<- read_csv2('people_dutch_real.csv')
NLspan_df <- mutate (life_a, lifespan = as.integer(deathYear)- as.integer(birthYear))%>%
  filter(birthYear>1861)
NLavr_df <- summarise (span_df, 'avr_span'= mean(lifespan), median_span = median(lifespan))
ggplot(data=span_df)+
  aes(x=birthYear, y=lifespan)+
  geom_point()

#And the same for South Africans

SAlife_all<- read_csv2('people_SA_real.csv')
SA_span_df <- mutate (life_a, lifespan = as.integer(deathYear)- as.integer(birthYear))%>%
  filter(birthYear>1861)
SA_avr_df <- summarise (span_df, 'avr_span'= mean(lifespan), median_span = median(lifespan))
ggplot(data=span_df)+
  aes(x=birthYear, y=lifespan)+
  geom_point()