import http_library
import csv # library to read/write/parse CSV files
from bs4 import BeautifulSoup # web-scraping library

acceptMime = 'text/html'

cikList = []
cikPath = 'cik.txt'
cikFileObject = open(cikPath, newline='')
cikRows = cikFileObject.readlines()

for cik in cikRows:
    cikList.append(cik.strip())

# create a list of dictionaries for appropriate results
resultsList = []
for cik in cikList:
    # this query string selects for 10-K forms, but also retrieves forms whose code start with 10-K
    baseUri = 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK='+cik+'&type=10-K&dateb=&owner=exclude&start=0&count=40&output=atom'
    print(baseUri)
    soup = BeautifulSoup(http_library.httpGet(baseUri,acceptMime)[1],features="html5lib")
    # this search string limits results to only category elements with the attribute that's exactly equal to"10-K"
    # the select function returns a list of soup objects that can each be searched
    for cat in soup.select('category[term="10-K"]'):
        # can't use cat.filing-href because hyphen in tag is interpreted by Python as a minus
        # also, couldn't get .strings to work, so used first child element (the string content of the tag)
        date = cat.find('filing-date').contents[0]
        year = date[:4]
        print(year)
        # create a dictionary of an individual result
        searchResults = {'cik':cik,'year':year,'uri':cat.find('filing-href').contents[0]}
        if year == "2016" or year == "2014":
            # append the dictionary to the list of results
            resultsList.append(searchResults)
print(resultsList)
#for hitNumber in range(0,1):  #for do only one hit for testing purposes
for hitNumber in range(0,len(resultsList)):
    print(hitNumber)
    soup = BeautifulSoup(http_library.httpGet(resultsList[hitNumber]['uri'],acceptMime)[1],features="html5lib")
    for row in soup.select('tr'):
        is10k = False
        for cell in row.select('td'):
            try:
                testString = cell.contents[0]
                if cell.contents[0] == "10-K":
                    is10k = True
            except:  # handle error caes where the cell doesn't have contents
                pass
        if is10k:
            print('http://www.sec.gov' + row.a.get('href'))
