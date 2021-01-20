 #Settings CODE
import json

            #Manually filtered json files
#First, we write some codes in bash in order to filter the json files for the criterias we were looking for,
 #which are entries that contain the string 'dutch', 'birthYear', and 'deathYear', excluding entries containing
 #containing the string 'fictional', and 'mythology'.

#khoatran@MacBook-Pro-6 People % cat \A_people.json |grep "deathYear"| grep "birthYear"| grep "Dutch" | grep -v
#"fictional" | grep -v "mythology" >.\A_people_filteredh.json

#We do this manually for all json files A->Z, changing the names of the files accordingly

#Create a list of alphabet letters
alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

# Creating an empty list that we could put the entries in
real_people = []
#Creating a for loop to load each json file:
for letter in alphabet:
    with open(f'{letter}_people_filteredh.json', encoding='utf-8') as file:
        #Run through each dictionary line by line
        for line in file:
            #Remove white spaces in the ends
            line = line.strip()
            #If the end of the list is comma, have the line end there
            if line[-1] == ',':
                line = line[:-1]
            line_dict = json.loads(line)
            #Append all the lines into the empty list
            real_people.append(line_dict)
#Create a csv file
with open('people_dutch_real.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people:
        birth= person['ontology/birthYear']
        death = person['ontology/deathYear']
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')


            #Automatically filtered files in the Shell
#We can also loop through the entire folder of people in the shell and get a single json file with all people we want:
# gci .\People\People\ | gc | sls "dutch" |sls "birthYear" |sls "deathYear" |sls -notmatch 'fictional'|select -expand Line >.\people_filtered_dutch.json
#Then we only have to go through the above steps for that one file, after saving it as UTF-8
real_people =[]
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
            real_people.append(line_dict)
with open('people_dutch_real.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people:
        birth= person['ontology/birthYear']
        death = person['ontology/deathYear']
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')

#Then we do the same for South Africa
#gci .\People\People\ | gc | sls "South Africa*" |sls "birthYear" |sls "deathYear"|sls -notmatch 'fictional'|select -expand Line >.\people_filtered_SA.json
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
            real_people.append(line_dict)
with open('people_SA_real.csv', 'w') as f:
    f.write('birthYear, deathYear\n')
    for person in real_people:
        birth= person['ontology/birthYear']
        death = person['ontology/deathYear']
        #possibly some metric for location
        f.write(f'{birth}, {death} \n')