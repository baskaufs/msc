import requests
import csv #library to read/write/parse CSV files

baseUrl = 'http://vuswwg-private.jelastic.servint.net/gom'
header = 'text/html'
csvObject = open('rs-not-404s.csv', newline='')
csvData = csv.reader(csvObject)
outObject = open('output.txt','wt')

rowNum = 0
for row in csvData:
    if rowNum != 0:    # the first row has headers rather than grades
        # find which column contains the identifier and which column contains the grade
        url = baseUrl+row[1]
        hdr = {'Accept' : header}
        r = requests.get(url, headers=hdr)
        if r.status_code == 404:
            response = ""
        else:
            response = r.text[:20]
        print(str(r.status_code)+"\t"+row[0]+"\t"+row[1]+"\t"+response)
        print(str(r.status_code)+"\t"+row[0]+"\t"+row[1]+"\t"+response, file=outObject)
    rowNum =+ 1
csvObject.close()
outObject.close()
