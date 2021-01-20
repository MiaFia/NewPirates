library (tidyverse)
library(readr)

social_high_life_expectancy <- read_delim("Social_High_Class_Life_expectancy_Middle.csv", 
                                                ";", escape_double = FALSE, trim_ws = TRUE)
life_expect_combined <- social_high_life_expectancy%>%
  mutate("Total"=((`Expectation of life at birth(years), Males`)+ 
                  (`Expectation of life at birth(years), Females`))/2)