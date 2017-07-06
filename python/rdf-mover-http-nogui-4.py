# XML creation functions hacked from http://code.activestate.com/recipes/577423-convert-csv-to-xml/

import csv #library to read/write/parse CSV files
import requests #library to do HTTP communication

def generateFilenameList(coreDoc):
	#does not include linked-metadata.csv, which must be processed differently
	filenameList = [{'name': 'namespace','tag': 'namespaces'},{'name': coreDoc + '-column-mappings','tag': 'column-index'},{'name': coreDoc + '-classes','tag': 'base-classes'}]
	return filenameList

def getCsvObject(httpPath, fileName, fieldDelimiter):
	# option to retrieve remotely from GitHub
	uri = httpPath + fileName
	r = requests.get(uri)
	print(str(r.status_code) + ' ' + uri)
	body = r.text
	csvData = csv.reader(body.splitlines()) # see https://stackoverflow.com/questions/21351882/reading-data-from-a-csv-file-online-in-python-3
	
	# option to retrieve from local file system
	#csvFile = 'c:\github\guid-o-matic\\' + fileName
	#csvData = csv.reader(open(csvFile, encoding = 'utf-8'), delimiter = fieldDelimiter)
	return csvData

def buildGenericXml(rootElementName, csvData):
	xmlData = ''
	xmlData = xmlData + '<' + rootElementName + '>' + "\n"
	
	rowNum = 0
	for row in csvData:
		if rowNum == 0:
			tags = row
			# replace spaces w/ underscores in tag names
			for i in range(len(tags)):
				tags[i] = tags[i].replace(' ', '_')
		else: 
			xmlData = xmlData + '<record>' + "\n"
			for i in range(len(tags)):
				xmlData = xmlData + '    ' + '<' + tags[i] + '>' + row[i] + '</' + tags[i] + '>' + "\n"
			xmlData = xmlData + '</record>' + "\n"
		rowNum +=1
	
	xmlData = xmlData + '</' + rootElementName + '>' + "\n"
	return xmlData
	
def buildLinkedMetadataXml(httpPath, csvData, fieldDelimiter):
	xmlData = '<?xml version="1.0" encoding="UTF-8" ?>' + '\n'
	xmlData = xmlData + '<linked-metadata>' + "\n"
	
	rowNum = 0
	for row in csvData:
		if rowNum == 0:
			tags = row
		else:
			xmlData = xmlData + '<file>' + "\n"
			
			xmlData = xmlData + '    ' + '<link_column>' + row[tags.index('link_column')] + '</link_column>' + "\n"
			xmlData = xmlData + '    ' + '<link_property>' + row[tags.index('link_property')] + '</link_property>' + "\n"
			xmlData = xmlData + '    ' + '<suffix1>' + row[tags.index('suffix1')] + '</suffix1>' + "\n"
			xmlData = xmlData + '    ' + '<link_characters>' + row[tags.index('link_characters')] + '</link_characters>' + "\n"
			xmlData = xmlData + '    ' + '<suffix2>' + row[tags.index('suffix2')] + '</suffix2>' + "\n"
			xmlData = xmlData + '    ' + '<class>' + row[tags.index('class')] + '</class>' + "\n"
			fileName = row[tags.index('filename')]
			fileNameRoot = fileName[0:fileName.find('.')]
			csvSubData = getCsvObject(httpPath, fileNameRoot + '-classes.csv', ',')
			xmlData = xmlData + buildGenericXml('classes', csvSubData)
			csvSubData = getCsvObject(httpPath, fileNameRoot + '-column-mappings.csv', ',')
			xmlData = xmlData + buildGenericXml('mapping', csvSubData)
			csvSubData = getCsvObject(httpPath, fileName, fieldDelimiter) # metadata file may have a different delimiter than comma
			xmlData = xmlData + buildGenericXml('metadata', csvSubData)
			
			xmlData = xmlData + '</file>' + "\n"
		rowNum +=1
	
	xmlData = xmlData + '</linked-metadata>' + "\n"
	return xmlData

def writeGenericXml(rootElementName, csvData, xmlFile):
	xmlData = open(xmlFile, 'w', encoding = 'utf-8')
	xmlData.write('<?xml version="1.0" encoding="UTF-8" ?>' + '\n')
	xmlString = buildGenericXml(rootElementName, csvData)
	xmlData.write(xmlString)
	xmlData.close()

def writeLinkedMetadataXml(httpPath, xmlFile, fieldDelimiter):
	xmlData = open(xmlFile, 'w', encoding = 'utf-8')
	csvData = getCsvObject(httpPath, 'linked-classes.csv', ',')
	xmlString = buildLinkedMetadataXml(httpPath, csvData, fieldDelimiter)
	xmlData.write(xmlString)
	xmlData.close()

def writeDatabaseFile(databaseWritePath, filename, body, pwd):
	uri = databaseWritePath + '/' + filename
	hdr = {'Content-Type' : 'application/xml'}
	r = requests.put(uri, auth=('admin', pwd), headers=hdr, data = body.encode('utf-8'))
	print(str(r.status_code) + ' ' + uri)
	print(r.text)

def outputData(githubRepo, repoSubpath, database, basexServerUri, pwd):
	databaseWritePath = basexServerUri + database

	# first must do a PUT to the database URI to create it if it doesn't exist
	r = requests.put(databaseWritePath, auth=('admin', '[pwd]') )
	print('create XML database')
	print(str(r.status_code) + ' ' + databaseWritePath)

	httpReadPath = 'https://raw.githubusercontent.com/' + githubRepo + 'master/' + repoSubpath + database + '/'
	# must open the configuration/constants file separately in order to discover the core document and separator character
	print('read constants')
	csvData = getCsvObject(httpReadPath, 'constants.csv', ',')
	
	# pull necessary constants out of the CSV object
	rowNum = 0
	for row in csvData:  # only one row of data below headers
		if rowNum == 0:
			tags = row
		else:
			coreDocFileName = row[tags.index('coreClassFile')]
			fieldDelimiter = row[tags.index('separator')]
		rowNum +=1
	# find the file name without extension
	coreDocRoot = coreDocFileName[0:coreDocFileName.find('.')]
	
	# write the configuration data; not sure why csvData wasn't preserved to this point ???
	print('read configuration')
	tempCsvData = getCsvObject(httpReadPath, 'constants.csv', ',')
	body = '<?xml version="1.0" encoding="UTF-8" ?>' + '\n' + buildGenericXml('constants', tempCsvData)
	print('write configuration')
	writeDatabaseFile(databaseWritePath, 'constants.xml', body, pwd)
	
	# write each of the various associated files	
	nameList = generateFilenameList(coreDocRoot)
	for name in nameList:
		print('read file')
		csvData = getCsvObject(httpReadPath, name['name'] + '.csv', ',')
		body = '<?xml version="1.0" encoding="UTF-8" ?>' + '\n' + buildGenericXml(name['tag'], csvData)
		print('write file')
		writeDatabaseFile(databaseWritePath, name['name'] + '.xml', body, pwd)
	
	# The main metadata file must be handled separately, since may have a non-standard file extension or delimiter
	print('read core metadata')
	csvData = getCsvObject(httpReadPath, coreDocFileName, fieldDelimiter)
	body = '<?xml version="1.0" encoding="UTF-8" ?>' + '\n' + buildGenericXml('metadata', csvData)
	print('write core metadata')
	writeDatabaseFile(databaseWritePath, coreDocRoot + '.xml', body, pwd)
	
	# The linked class data has a different format and must be handled separately
	print('read linked metadata')
	csvData = getCsvObject(httpReadPath, 'linked-classes.csv', ',')
	body = buildLinkedMetadataXml(httpReadPath, csvData, fieldDelimiter)
	print('write linked metadata')
	writeDatabaseFile(databaseWritePath, 'linked-classes.xml', body, pwd)

def main():	
	# outputData('HeardLibrary/semantic-web/', '2016-fall/', 'tang-song', 'http://vuswwg.jelastic.servint.net/gom/rest/', '[pwd]')
	outputData('VandyVRC/tcadrt/', '', 'building', 'http://vuswwg.jelastic.servint.net/gom/rest/', '[pwd]')

if __name__=="__main__":
	main()
