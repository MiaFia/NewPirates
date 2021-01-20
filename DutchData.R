library(tidyverse)
library(readr)
library('ggthemes')
Sys.setenv(LANG= "en")
Levensverwachting <- read_delim("Levensverwachting_vanaf_1861_20012021_113307.csv", 
                                        ";", escape_double = FALSE, trim_ws = TRUE)

Levens2<- Levensverwachting %>%
  filter(grepl('tot', Perioden, fixed = TRUE))%>%
  filter(grepl('0 jaar', `Leeftijd (op 31 december)`, fixed = FALSE))%>%
  filter(Geslacht == "Mannen" | Geslacht == "Vrouwen")%>%
  select(-`Sterftekans (kans)`, -`Levenden (tafelbevolking)  (aantal)`,
         -`Overledenen (tafelbevolking)  (aantal)`, -`Leeftijd (op 31 december)`)

Levens3 <- Levens2%>%
  group_by(Geslacht)%>%
  pivot_wider(names_from = Geslacht, values_from= `Levensverwachting (jaar )`)%>%
  mutate("Lifeexpectance_combined"
         =(as.integer(Mannen)+as.integer(Vrouwen))/2)

Levens4 <- Levens3 %>%
  summarize("median_men" = median(as.integer(Mannen)),
            "median_women" = median(as.integer(Vrouwen)),
            "median_all" = median(as.integer(Lifeexpectance_combined)),
            mean_men= mean(as.integer(Mannen)),
            mean_women= mean(as.integer(Vrouwen)),
            mean_all= mean(as.integer(Lifeexpectance_combined)))

#Then we can also graph this to make the trends visible
ggplot(data=Levens3)+
  aes(x=Perioden, y=Lifeexpectance_combined)+
  geom_point()+
  labs(title = 'Life expectancy Netherlands',
       subtitle = 'Life expectancy since Birth Year 1861, per 5 year cohort',
       caption = "Source: Centraal Bureau voor de Statistiek",
       x = 'Birth Year cohorts',
       y = 'Life expectancy in years')+
  theme_light()+
  scale_x_discrete(breaks = c("1861 tot 1866" ,"1891 tot 1896", "1921 tot 1926", "1951 tot 1956", "1981 tot 1986"))