import requests
import csv #library to read/write/parse CSV files
import time

baseUrl = 'http://rs-test.tdwg.org'
header = 'text/html'
outObject = open('output-hit.txt','wt')
url = baseUrl + '/dwc/terms/recordedBy.ttl'
for count in range(1000):
    hdr = {'Accept' : header}
    r = requests.get(url, headers=hdr)
    if r.status_code == 404:
        response = ""
    else:
        response = r.text[:5]
    t = time.time()
    print(count,t)
    print(str(r.status_code)+"\t"+ str(t) +"\t"+response, file=outObject)
outObject.close()
