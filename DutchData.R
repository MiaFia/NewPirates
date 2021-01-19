library(tidyverse)
library(readr)
Sys.setenv(LANG= "en")
Levensverwachting <- read_delim("LevensverwachtingStatline.csv", 
                                        ";", escape_double = FALSE, trim_ws = TRUE)

Levens2<- Levensverwachting %>%
  #filter(grepl('en', Geslacht, fixed = FALSE))%>%
  filter(grepl('tot', Perioden, fixed = TRUE))%>%
  filter(grepl('0 jaar', `Leeftijd (op 31 december)`, fixed = FALSE))%>%
  select(-`Sterftekans (kans)`, -`Levenden (tafelbevolking)  (aantal)`,
         -`Overledenen (tafelbevolking)  (aantal)`, -`Leeftijd (op 31 december)`)

Levens3 <- Levens2%>%
  group_by(Geslacht)%>%
  pivot_wider(names_from = Geslacht, values_from= `Levensverwachting (jaar )`)
  



