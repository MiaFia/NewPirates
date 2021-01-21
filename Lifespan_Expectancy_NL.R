library(tidyverse)
library(readr)
library('ggthemes')
Sys.setenv(LANG= "en")

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

#We filter the set so it only uses the data for cohorts and life expectancy at age 21
Levens2<- Levensverwachting %>%
  filter(grepl('tot', Perioden, fixed = TRUE))%>%
  filter(grepl('21 jaar', `Leeftijd (op 31 december)`, fixed = FALSE))%>%
  filter(Geslacht == "Mannen" | Geslacht == "Vrouwen")%>%
  select(-`Sterftekans (kans)`, -`Levenden (tafelbevolking)  (aantal)`,
         -`Overledenen (tafelbevolking)  (aantal)`, -`Leeftijd (op 31 december)`)

#We then found the average life expectancy for each group and across both genders, assuming their split to be 50/50
Levens3 <- Levens2%>%
  group_by(Geslacht)%>%
  pivot_wider(names_from = Geslacht, values_from= `Levensverwachting (jaar )`)%>%
  mutate("Lifeexpectance_combined"
         =(as.integer(Mannen)+as.integer(Vrouwen))/2)%>%
  mutate("Levensverwacht"= (as.integer(Lifeexpectance_combined)+21))

#As the data deals in groups of 5 years, we determined the middle of the period and assigned the value of the period to it
numeric_years <- Levens3 %>%
  separate(Perioden,into= c("PeriodStart", "PeriodEnd"), sep= " tot ", remove = TRUE, convert = TRUE)%>%
  mutate(PeriodMiddle= ((((PeriodStart)+(PeriodEnd)))/2)-21)#%>%
  #filter (PeriodEnd<=1931)

#We get the Life expectancy at birth
Levens_0<-Levensverwachting %>%
  filter(grepl('tot', Perioden, fixed = TRUE))%>%
  filter(grepl('0 jaar', `Leeftijd (op 31 december)`, fixed = FALSE))%>%
  filter(Geslacht == "Mannen" | Geslacht == "Vrouwen")%>%
  select(-`Sterftekans (kans)`, -`Levenden (tafelbevolking)  (aantal)`,
         -`Overledenen (tafelbevolking)  (aantal)`, -`Leeftijd (op 31 december)`)  

Levens0 <- Levens_0%>%
  group_by(Geslacht)%>%
  pivot_wider(names_from = Geslacht, values_from= `Levensverwachting (jaar )`)%>%
  mutate("Lifeexpectance_combined"
         =(as.integer(Mannen)+as.integer(Vrouwen))/2)

#As the data deals in groups of 5 years, we determined the middle of the period and assigned the value of the period to it
numeric0_years <- Levens0 %>%
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
  filter(birthYear <= 1931)%>%
  arrange(birthYear)

#Grouping the entries by year and calculating the mean life
people_dutch_grouped <- people_dutch_new %>%
  group_by(birthYear)%>%
  summarise(average_life = mean(lifespan))

#Graph 1: Dutch government old and new:
ggplot(data = people_dutch_grouped)+ 
  geom_line( aes(x = birthYear, y = average_life, color ='DPedia Life spans'),size=0.5) + 
  geom_smooth(data= people_dutch_grouped, aes(x = birthYear, y = average_life, color ='DPedia Life spans'),size =1.5, method='lm') +
  geom_line (data=numeric_years, aes(x=PeriodMiddle, y=Levensverwacht, color='Dutch Government 21'))+
  geom_line (data=numeric0_years, aes(x=PeriodMiddle, y=Lifeexpectance_combined, color='Dutch Government at birth'))+
labs(title = "Average life spans and life expectancy in Netherlands",
     subtitle= 'Life span of Dutch people with a Wikipedia entry against two types of life expectancy',
     x="Average life span per year",
     y="Year",
     color = 'Sources') +
  theme_light(base_size = 16)+
  scale_y_continuous(limits = c(0,90))+
  scale_x_continuous(limits=c(1860, 1930))

#Graph 2: Antonovsky data
ggplot(data = people_dutch_grouped)+ 
  geom_line( aes(x = birthYear, y = average_life, color ='DPedia Life spans'),size=0.5) + 
  geom_smooth(data= people_dutch_grouped, aes(x = birthYear, y = average_life, color ='DPedia Life spans'),size = 1.5, method='lm') +
   #and a line graph for the older times data
  geom_line(data=early_life_expect_combined, aes(x= `Middle of Period of Birth`, y= Total, color='Antonovsky'))+
  geom_point(data=early_life_expect_combined, aes(x= `Middle of Period of Birth`, y= Total, color='Antonovsky'))+
  labs(title = "Average life spans and life expectancy in Netherlands",
       subtitle= 'Life span of Dutch people with a Wikipedia entry compared to life expectancies 1330-1930',
       x="Birth Year",
       y="Average Life span per year",
       color = 'Sources') +
  theme_light(base_size = 16)+
  scale_y_continuous(limits = c(0,90))+
  scale_x_continuous(limits=c(1330, 1930))