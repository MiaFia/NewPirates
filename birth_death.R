#This might merge all the files?
install.packages("dplyr")                                    
install.packages("plyr")   
install.packages("readr")                

library("dplyr")                                                 
library("plyr") 
library("readr") 
library (tidyverse)
life_all <- list.files(path=".\People\Filtered",pattern = "*.csv", full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows 

span_df <- mutate (life_all, 'lifespan' = deathYear- birthYear)