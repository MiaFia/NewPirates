#Settings CODE
import json
import os
#First filter the file in the shell using commands gc .\People\People\A_people.json | sls "dutch" |sls "birthYear" |sls "deathYear" %{$_.Line}>.\A_people_filtered.json
#Then manually add the square brackets and save it in utf-8
# with open (f'A_dutch_people_filtered.json', encoding= 'utf-8') as file:
#     real_people_A= json.loads(file.read().replace('\n',''))

# directory= os.fsencode('C:\Users\User\Documents\MET2J\python_kitchen\Final_project.py\NewPirates\People\People', encoding='UTF-8')

# for file in os.listdir(directory):
#     filename = os.fsdecode(file)
#     if filename.endswith(".json"):

directory = r'C:\Users\User\Documents\MET2J\python_kitchen\Final_project.py\NewPirates\People\People'

for filename in os.listdir(directory):
    if filename.endswith(".json"):
# Now we can add our variables into a csv file:
<<<<<<< HEAD
        #for letters in file_list:
        with open('people_a.csv', 'w') as f:
            f.write('birthYear, deathYear\n')
            for person in filename:
                birth= person['ontology/birthYear']
                death = person['ontology/deathYear']
                #possibly some metric for location
                f.write(f'{birth}, {death} \n')
    else:
        continue
=======
with open('people_a.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people:
        birth= int(person['ontology/birthYear'])
        death = int(person['ontology/deathYear'])
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')
# How do we get all people with all letters in here?
>>>>>>> 8aaf47fe8b573de75aa2f41b7cedcb301eef7758
