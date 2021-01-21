 #Automatically filtered files in the Shell
#Settings Code
import json

#We can also loop through the entire folder of people in the shell and get a single json file with all people we want:
# gci .\People\People\ | gc | sls "dutch" |sls "birthYear" |sls "deathYear" |sls -notmatch 'fictional' |sls -notmatch 'mythological' |select -expand Line >.\people_filtered_dutch.json
#Safe this file as UTF-8
#Then we only have to go through the above steps for that one file, after saving it as UTF-8
real_people_NL =[]
with open('people_filtered_dutch.json', encoding='utf-8') as file:
        #Run through each dictionary line by line
        for line in file:
            #Remove white spaces in the ends
            line = line.strip()
            #If the end of the list is comma, have the line end there
            if line[-1] == ',':
                line = line[:-1]
            line_dict = json.loads(line)
            #Append all the lines into the empty list
            real_people_NL.append(line_dict)
with open('people_dutch_real.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people_NL:
        birth= person['ontology/birthYear']
        death = person['ontology/deathYear']
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')

# Then we do the same for South Africa
# gci .\People\People\ | gc | sls "South Africa*" |sls "birthYear" |sls "deathYear"|sls -notmatch 'fictional'|sls -notmatch 'mythological'|select -expand Line >.\people_filtered_SA.json
# The resulting json has to be save with the encoding utf-8
real_people_SA=[]
with open('people_filtered_SA.json', encoding='utf-8') as file:
        #Run through each dictionary line by line
        for line in file:
            #Remove white spaces in the ends
            line = line.strip()
            #If the end of the list is comma, have the line end there
            if line[-1] == ',':
                line = line[:-1]
            line_dict = json.loads(line)
            #Append all the lines into the empty list
            real_people_SA.append(line_dict)
with open('people_SA_real.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people_SA:
        birth= person['ontology/birthYear']
        death = person['ontology/deathYear']
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')