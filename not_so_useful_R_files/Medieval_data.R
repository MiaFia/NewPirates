library(tidyverse)

expectancy_europe<- read_csv('t0004-10.1080_00324728.2013.765955.csv')
sum_expectancy<-mutate(expectancy_europe, avr_life= mean(is.numeric('1650-99')))
                          
mutate (expectancy_europe, avr_life= mean(is.numeric('1350-1399'))