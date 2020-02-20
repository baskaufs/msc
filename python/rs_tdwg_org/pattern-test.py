import requests
import csv #library to read/write/parse CSV files
import time

baseUrl = 'http://rs-test.tdwg.org/'
headers = ['text/html', 'text/turtle', 'application/rdf+xml', 'application/ld+json']
csvObject = open('test-url-patterns.csv', newline='')
csvData = csv.reader(csvObject)
outObject = open('output.txt','wt')

rowNum = 0
for header in headers:
    for row in csvData:
        if rowNum != 0:    # the first row has headers
            url = baseUrl+row[0]
            hdr = {'Accept' : header}
            r = requests.get(url, headers=hdr)
            if r.status_code == 404:
                response = ""
            else:
                response = r.text[:20]
            t = time.time()
            print(str(r.status_code)+"\t"+row[0]+"\t"+row[1]+"\t"+str(t))
            print(str(r.status_code)+"\t"+row[0]+"\t"+row[1]+"\t"+str(t), file=outObject)
        rowNum =+ 1
csvObject.close()
outObject.close()
