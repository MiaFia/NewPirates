#Settings CODE
import json

#First filter the file in the shell using commands gc .\People\People\A_people.json | sls "citizenship" |sls "birthYear" |sls "deathYear" %{$_.Line}>.\A_people_filtered.json
#Then manually add the square brackets and save it in utf-8
with open ('A_dutch_people_filtered.json', encoding= 'utf-8') as file:
    real_people= json.loads(file.read().replace('\n',''))

# Now we can add our variables into a csv file:
with open('people_a.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people:
        birth= person['ontology/birthYear']
        death = person['ontology/deathYear']
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')