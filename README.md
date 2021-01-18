# NewPirates

This is the code to filter out Dutchies:
 gc .\A_people.json |sls "deathYear"| sls "birthYear"| sls "Dutch" >.\A_people_filteredh.json
 
 And this for South Africans:
 
  gc .\A_people.json |sls "deathYear"| sls "birthYear"| sls "South African" >.\A_people_filteredSA.json
