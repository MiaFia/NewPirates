# NewPirates
This repository creates graphs comparing the average lifespan of people with a wikipedia article and the life expectancy for their country or origin. This can be done for the Netherlands and South Africa.

First the python file filtering_data.py should be opened. There two things are possible: 
either: manually go through each file in the People folder using the first shell command and the running the top python lines
or: scroll down and run the other shell command through the entire folder in the shell and use the second set of python commands

Then the resulting .csv files for the countries are used in the R scripts Lifespan_Expectancy_Country.R

\
For that two datasets have to be downloaded from outside:

How to get to the Datasets we chose:\
https://data.overheid.nl/dataset/318-levensverwachting--geslacht--leeftijd--per-jaar-en-periode-van-vijf-jaren-
Then click on WEbservice, choose the first link and immediatly download the csv.

https://www.gapminder.org/data/
select the filter 'life expectancy'
This filter could also be added manually but since the original csv is really big we decided to use this pre-applied filter and downloaded it as a csv.

\
This data set has already been copied into a csv file which is for download in this repository
https://doi.org/10.2307/3348839, page 33
copy the table into a csv file
Read into R.

These two files should be opened in the working directory along with the R code, so it runs. 
