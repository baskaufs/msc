# Steve Baskauf 2018-10-31 Freely available under a GNU GPLv3 license. 
# By its nature, this software overwrites and deletes data, so use at your own risk. 
# See https://github.com/baskaufs/guid-o-matic/blob/master/rdf-mover.md for usage notes about the script this was hacked from.

import csv #library to read/write/parse CSV files
import requests #library to do HTTP communication

localPath = 'c:\\github\\rs.tdwg.org\\'
findString = 'rs.tdwg.org'
replaceString = 'rs-test.tdwg.org'

def loadListIndex():
	csvData = getCsvObject('https://raw.githubusercontent.com/tdwg/rs.tdwg.org/test/index/', 'index-datasets.csv', ',')
	loadList = []
	for row in csvData:
		loadList.append(row[1])
	for database in range(1,len(loadList)):  # start range at 1 to avoid header row (0)
	#for database in range(1,2):  # uncomment this line to test using only one database
		# for whatever reason, the .ttl serializations of the dumps were loading zero triples.  But the .rdf serializations were fine.
		# I'm wondering if this is related to the content-type reported by the dump.  I verified that it's "text/turtle", which I thought was a valid type to load
#        dataToTriplestore(dumpUriBox.get(), loadList[database]+'.rdf', endpointUriBox.get(), graphNameBox.get(), passwordBox2.get())
		print(localPath+loadList[database])
		configCsv = open(localPath+loadList[database]+'\\constants.csv', newline='')
		configData = csv.reader(configCsv)
		for line in configData:
			for string in line:
				if findString in string:
					print(string)


def getCsvObject(httpPath, fileName, fieldDelimiter):
	# retrieve remotely from GitHub
	uri = httpPath + fileName
	r = requests.get(uri)
	print(str(r.status_code) + ' ' + uri)
	body = r.text
	csvData = csv.reader(body.splitlines()) # see https://stackoverflow.com/questions/21351882/reading-data-from-a-csv-file-online-in-python-3
	return csvData
	
def escapeBadXmlCharacters(dirtyString):
	ampString = dirtyString.replace('&','&amp;')
	ltString = ampString.replace('<','&lt;')
	cleanString = ltString.replace('>','&gt;')
	return cleanString

def performSparqlUpdate(endpointUri, pwd, updateCommand):
	# SPARQL Update requires HTTP POST
	updateLog(updateCommand + '\n')
	hdr = {'Content-Type' : 'application/sparql-update'}
	r = requests.post(endpointUri, auth=('admin', pwd), headers=hdr, data = updateCommand)
	updateLog(str(r.status_code) + ' ' + r.url + '\n')
	updateLog(r.text + '\n')
	updateLog('Ready')	

def dataToTriplestore(dumpUri, database, endpointUri, graphName, pwd):
    updateCommand = 'LOAD <' + dumpUri + database + '> INTO GRAPH <' + graphName + '>'
    print(updateCommand) # print this to the terminal so that we can see what's going on while the GUI is doing spinning circle
    updateLog('update SPARQL endpoint into graph ' + graphName)
    performSparqlUpdate(endpointUri, pwd, updateCommand)

loadListIndex()
