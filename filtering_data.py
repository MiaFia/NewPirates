#Settings CODE
import json

#First filter the file in the shell using commands gc .\People\People\A_people.json | sls "citizenship" |sls "birthYear" |sls "deathYear" %{$_.Line}>.\A_people_filtered.json
#Then manually add the square brackets and save it in utf-8
#Then load it into Python as a file
with open ('A_dutch_people_filtered.json', encoding= 'utf-8') as file:
    real_people= json.loads(file.read().replace('\n',''))


with open('people_a.csv', 'w') as f:
    f.write('Citizenship, birthYear, deathYear\n')

# for person in real_people:
#     #if ontology/birthYear<onotology/deathYear:
#         #lifetime = deathYear - birthYear
#     f.write(f"{Citizenship['citizenship']},{birthYear['ontology/birthYear']},{deathYear['onotology/deathYear']}\n")

#I'm trying stuff with a list

list_of_dutch_a = []

for person in real_people:
    birth= person['ontology/birthYear']
    death = person['ontology/deathYear']
    #and add those to a list!
    list_of_dutch_a.append({'birth': birth, 'death': death})

print(list_of_dutch_a)
