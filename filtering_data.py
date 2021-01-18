#Settings CODE
import json

#First filter the file in the shell using commands gc .\People\People\A_people.json | sls "citizenship" |sls "birthYear" |sls "deathYear" >.\A_people_filtered.json

#Then load it into Python as a file
with open ('A_dutch_people_filtered.json') as file:
    real_people= (json.load(file))

# with open('people_a.csv', 'w') as f:
#     f.write('Citizenship, birthYear, deathYear\n')

# for person in real_people:
#     if birthYear<deathYear:
#         lifetime = deathYear - birthYear
#     f.write(f"{Citizenship['citizenship']},{birthYear['birthYear']},{deathYear['deathYear']}, {lifespan['lifetime']} \n")