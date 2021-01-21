library(tidyverse)
library(readr)
library('ggthemes')
Sys.setenv(LANG= "en")

#The first data is from gapminder (download before)
life_expectancy_years <- read_csv("life_expectancy_years.csv")

#As this file includes life expectancy per year for many countries, we filter the dutch values out and take those up until 1931
life_expectancy_NL <- life_expectancy_years%>%
  filter(country== "Netherlands")%>%
  pivot_longer(cols = c('1800':'2100'), names_to="Year", values_to="Expectancy")%>%
  filter(as.integer(Year)<1931)

#With the data file from the github we get life expectancy approximations from before 1800
early_life_expectancy <- read_delim("Social_High_Class_Life_expectancy_Middle.csv", 
                                          ";", escape_double = FALSE, trim_ws = TRUE)
early_life_expect_combined <- early_life_expectancy%>%
  mutate("Total"=((`Expectation of life at birth(years), Males`)+ 
                    (`Expectation of life at birth(years), Females`))/2)%>%
  group_by(`Middle of Period of Birth`)

#A dataset by the dutch government to supply more data
Levensverwachting <- read_delim("Levensverwachting_vanaf_1861_20012021_113307.csv", 
                                ";", escape_double = FALSE, trim_ws = TRUE)

#We filter the set so it only uses the data for cohorts and life expectancy at birth
Levens2<- Levensverwachting %>%
  filter(grepl('tot', Perioden, fixed = TRUE))%>%
  filter(grepl('0 jaar', `Leeftijd (op 31 december)`, fixed = FALSE))%>%
  filter(Geslacht == "Mannen" | Geslacht == "Vrouwen")%>%
  select(-`Sterftekans (kans)`, -`Levenden (tafelbevolking)  (aantal)`,
         -`Overledenen (tafelbevolking)  (aantal)`, -`Leeftijd (op 31 december)`)

#We then found the average life expectancy for each group and across both genders, assuming their split to be 50/50
Levens3 <- Levens2%>%
  group_by(Geslacht)%>%
  pivot_wider(names_from = Geslacht, values_from= `Levensverwachting (jaar )`)%>%
  mutate("Lifeexpectance_combined"
         =(as.integer(Mannen)+as.integer(Vrouwen))/2)

#As the data deals in groups of 5 years, we determined the middle of the period and assigned the value of the period to it
numeric_years <- Levens3 %>%
  separate(Perioden,into= c("PeriodStart", "PeriodEnd"), sep= " tot ", remove = TRUE, convert = TRUE)%>%
  mutate(PeriodMiddle= (((PeriodStart)+(PeriodEnd)))/2)%>%
  filter (PeriodEnd<=1931)
  


#Then we find the life span for dutch Wikipedia people
#Creating a variable for the csv file
people_dutch <- read_csv("people_dutch_real.csv",col_types = "ii")

#Piping the data so we could get valid entries for complete cohorts, as well as getting a 
people_dutch_new <- people_dutch %>%
  mutate("lifespan" = deathYear - birthYear) %>%
  filter(lifespan > 0 & lifespan < 120) %>%
  filter(birthYear <= 1931)
arrange(birthYear)

#Grouping the entries by year and calculating the mean life
people_dutch_grouped <- people_dutch_new %>%
  group_by(birthYear)%>%
  summarise(average_life = mean(lifespan))

View(people_dutch_grouped)

#Creating a graph for the average life span and the life expectancy for Netherlands 
#first we make a point graph for the lifespans of our data, and a smooth to show average trends
ggplot(data = people_dutch_grouped)+ geom_point( aes(x = birthYear, y = average_life, color ='DPedia Life spans'),size=0.5) + 
  geom_smooth(data= people_dutch_grouped, aes(x = birthYear, y = average_life, color ='DPedia Life spans'),method='lm') +
  #the we create a point graph and a smooth line for the gapminder life expectancy
  geom_line(data=life_expectancy_NL, aes(x=(as.integer(Year)), y=Expectancy, color= 'Gapminder'))+
  #geom_smooth(data= life_expectancy_NL,aes(x=(as.integer(Year)), y=Expectancy, color ='Gapminder'),method='lm')+
  #and a line graph for the older times data
  geom_line(data=early_life_expect_combined, aes(x= `Middle of Period of Birth`, y= Total, color='Antonovsky'))+
  #and finally a graph for the dutch government data
  geom_line(data=numeric_years, aes(x=PeriodMiddle, y=Lifeexpectance_combined, color='Dutch Government'))+
  labs(title = "Average life spans and life expectancy in Netherlands",
       subtitle= 'The average life span of Dutch people with a Wikipedia entry, in the 897-1931 period (completed cohorts)',
       x="Average life span per year",
       y="Year",
       color = 'Sources') +
  theme_light(base_size = 16)+
  scale_y_continuous(limits = c(0,90))