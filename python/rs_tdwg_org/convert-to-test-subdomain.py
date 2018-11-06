# Steve Baskauf 2018-10-31 Freely available under a GNU GPLv3 license. 
# By its nature, this software overwrites and deletes data, so use at your own risk. 
# See https://github.com/baskaufs/guid-o-matic/blob/master/rdf-mover.md for usage notes about the script this was hacked from.

import csv #library to read/write/parse CSV files
import requests #library to do HTTP communication

localPath = 'c:\\temp\\rs.tdwg.org\\'
findString = 'rs.tdwg.org'
replaceString = 'rs-test.tdwg.org'
writePathDir = "c:\\github\\rs.tdwg.org\\"

def loadListIndex():
	csvData = getCsvObject('https://raw.githubusercontent.com/tdwg/rs.tdwg.org/test/index/', 'index-datasets.csv', ',')
	loadList = []
	for row in csvData:
		loadList.append(row[1])
	for database in range(1,len(loadList)):  # start range at 1 to avoid header row (0)
	#for database in range(1,2):  # uncomment this line to test using only one database
		dbase = loadList[database]  # dbase is the string name of the database
		print(localPath + dbase)

		localFilePath = localPath + dbase + '\\constants.csv'
		writePath = writePathDir + dbase + '\\constants.csv'
		replaceDomainName(localFilePath,writePath)

		if dbase == 'dwc-translations':
			fname = 'dwcTranslations'
		else:
			fname = dbase
		localFilePath = localPath + dbase + '\\' + fname + '.csv'
		writePath = writePathDir + dbase + '\\' + fname + '.csv'
		replaceDomainName(localFilePath,writePath)

		if dbase != 'decisions' and dbase != 'docs' and dbase != 'docs-roles' and dbase != 'dwc-translations' and dbase != 'standards' and dbase != 'term-lists' and dbase != 'vocabularies' and dbase != 'index':
			localFilePath = localPath + dbase + '\\'+ dbase + '-replacements.csv'		
			writePath = writePathDir + dbase + '\\' + dbase + '-replacements.csv'
			replaceDomainName(localFilePath,writePath)

		if '-versions' not in dbase:
			if dbase != 'decisions' and dbase != 'docs-roles' and dbase != 'dwc-translations' and dbase != 'index':
				localFilePath = localPath + dbase + '\\'+ dbase + '-versions.csv'		
				writePath = writePathDir + dbase + '\\' + dbase + '-versions.csv'
				replaceDomainName(localFilePath,writePath)

		if dbase == 'decisions':
			localFilePath = localPath + dbase + '\\'+ dbase + '-links.csv'		
			writePath = writePathDir + dbase + '\\' + dbase + '-links.csv'
			replaceDomainName(localFilePath,writePath)

		if dbase == 'docs' or dbase == 'docs-versions':
			localFilePath = localPath + dbase + '\\'+ dbase + '-authors.csv'		
			writePath = writePathDir + dbase + '\\' + dbase + '-authors.csv'
			replaceDomainName(localFilePath,writePath)

			localFilePath = localPath + dbase + '\\'+ dbase + '-formats.csv'		
			writePath = writePathDir + dbase + '\\' + dbase + '-formats.csv'
			replaceDomainName(localFilePath,writePath)

		if dbase == 'standards' or dbase == 'standards-versions':
			localFilePath = localPath + dbase + '\\'+ dbase + '-parts.csv'		
			writePath = writePathDir + dbase + '\\' + dbase + '-parts.csv'
			replaceDomainName(localFilePath,writePath)

		if dbase == 'term-lists' or dbase == 'term-lists-versions':
			localFilePath = localPath + dbase + '\\'+ dbase + '-members.csv'		
			writePath = writePathDir + dbase + '\\' + dbase + '-members.csv'
			replaceDomainName(localFilePath,writePath)

def replaceDomainName(localFilePath,writePath):
	configCsv = open(localFilePath, newline='', encoding='utf-8')
	configData = csv.reader(configCsv)
	testWriteCsv = open(writePath, 'w', newline='', encoding='utf-8')
	testWriteData = csv.writer(testWriteCsv)
	row=0
	for line in configData:
		lineList = []
		for string in line:
			if row == 0:  # header row
				newString = string
			else:        # data rows
				if findString in string:
					newString = string.replace(findString,replaceString)
				else:
					newString = string
			lineList.append(newString)
		testWriteData.writerow(lineList)
		row += 1
	testWriteCsv.close()
	configCsv.close()

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
