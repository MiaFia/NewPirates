library(tidyverse)
library(readr)
Sys.setenv(LANG= "en")
Levensverwachting <- read_delim("LevensverwachtingStatline.csv", 
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
         =(as.integer(Mannen)+as.integer(Vrouwen))/2)%>%

Levens4 <- Levens3 %>%
  summarize("median_men" = median(as.integer(Mannen)),
            "median_women" = median(as.integer(Vrouwen)),
            "median_all" = median(as.integer(Lifeexpectance_combined)))


  



