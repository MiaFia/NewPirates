#This might merge all the files?
install.packages("dplyr")                                    
install.packages("plyr")   
install.packages("readr")                

library("dplyr")                                                 
library("plyr") 
library("readr") 
library (tidyverse)
life_all <- list.files(path = './People/filtered', 
                       pattern = '*.csv', full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows 

span_df <- mutate (life_all, lifespan = as.integer(deathYear)- as.integer(birthYear))
avr_df <- summarise (span_df, 'avr_span'= mean(lifespan))