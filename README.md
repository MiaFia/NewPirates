# NewPirates

This is the code to filter out Dutchies:
 gci .\People\People\ | gc | sls "dutch" |sls "birthYear" |sls "NaturalPerson" |sls "deathYear"|select -expand Line >.\people_filteredNL.json
 
 And this for South Africans:
 
  gci .\People\People\ | gc | sls "South African" |sls "birthYear" |sls "NaturalPerson" |sls "deathYear"|select -expand Line >.\people_filteredSA.json

How to get a .csv file:

   with open('people_a.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people:
        birth= person['ontology/birthYear']
        death = person['ontology/deathYear']
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')


How to get to the Dataset we chose:
https://data.overheid.nl/dataset/318-levensverwachting--geslacht--leeftijd--per-jaar-en-periode-van-vijf-jaren-
Then click on one of the links and there we downloaded it as csv immediately instead of doing the API thing.
