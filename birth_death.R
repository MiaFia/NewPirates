library (tidyverse)
life_df <- read_csv('people_a.csv')
span_df <- mutate (life_df, 'lifespan' = deathYear- birthYear)
#this is the lifespan of dutch people with A now!