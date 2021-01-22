# NewPirates
This repository creates graphs comparing the average lifespan of people with a wikipedia article and the life expectancy for their country or origin. This can be done for the Netherlands and South Africa.

First the python file should be opened. There two ways that are possible: 
Automatic_filtering.py gives a commmandline command, that runs trough the entire folder 'People' and outputs a single filtered json file, which the python code then runs for.
Manually_filtering.py gives a command that has to be applied to each file in the folder and outputs seperete json files. The python code the  runs through that entire folder.
Both output the same csv files, that can then be used in R.

Then the resulting .csv files for the countries are used in the R scripts Lifespan_Expectancy_NL.R or Lifespan_Expectancy_SA.R 
To compare the two countries, run the R file titled: 'Comparison_NL_SA.R'

The R file DataBothCountries.r graphs the life expectancies from gapminder of both NL and SA
\
For that two datasets have to be downloaded from outside:

How to get to the Datasets we chose:\
https://data.overheid.nl/dataset/318-levensverwachting--geslacht--leeftijd--per-jaar-en-periode-van-vijf-jaren-
Then click on WEbservice, choose the first link and immediatly download the csv.

https://www.gapminder.org/data/
select the filter 'life expectancy'
This filter could also be added manually but since the original csv is really big we decided to use this pre-applied filter and downloaded it as a csv.

\
This data set has already been copied into a csv file which is for download in this repository under the name:
Social_High_Class_Life_expectancy_Middle.csv
This is the actual source:
https://doi.org/10.2307/3348839, page 33
copy the table into a csv file

These two files should be opened in the working directory along with the R code, so it runs. 
