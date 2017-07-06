# XML creation functions hacked from http://code.activestate.com/recipes/577423-convert-csv-to-xml/

import csv

def generateFilenameList(coreDoc):
	#does not include linked-metadata.csv, which must be processed differently
	filenameList = [{'name': coreDoc + '-column-mappings','tag': 'column-index'},{'name': 'namespace','tag': 'namespaces'},{'name': coreDoc + '-classes','tag': 'base-classes'}]
	return filenameList

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
	
def buildLinkedMetadataXml(csvData, fieldDelimiter):
	xmlData = '<?xml version="1.0" encoding="UTF-8" ?>' + "\n"
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
			csvSubData = getCsvObject(fileNameRoot + '-classes.csv', ',')
			xmlData = xmlData + buildGenericXml('classes', csvSubData)
			csvSubData = getCsvObject(fileNameRoot + '-column-mappings.csv', ',')
			xmlData = xmlData + buildGenericXml('mapping', csvSubData)
			csvSubData = getCsvObject(fileName, fieldDelimiter) # metadata file may have a different delimiter than comma
			xmlData = xmlData + buildGenericXml('metadata', csvSubData)
			
			xmlData = xmlData + '</file>' + "\n"
		rowNum +=1
	
	xmlData = xmlData + '</linked-metadata>' + "\n"
	return xmlData

def writeGenericXml(rootElementName, csvData, xmlFile):
	xmlData = open(xmlFile, 'w', encoding = 'utf-8')
	xmlData.write('<?xml version="1.0" encoding="UTF-8" ?>' + "\n")
	xmlString = buildGenericXml(rootElementName, csvData)
	xmlData.write(xmlString)
	xmlData.close()

def writeLinkedMetadataXml(xmlFile, fieldDelimiter):
	xmlData = open(xmlFile, 'w', encoding = 'utf-8')
	csvData = getCsvObject('linked-classes.csv', ',')
	xmlString = buildLinkedMetadataXml(csvData, fieldDelimiter)
	xmlData.write(xmlString)
	xmlData.close()

def getCsvObject(fileName, fieldDelimiter):
	# option to retrieve from local file system
	csvFile = 'c:\github\guid-o-matic\\' + fileName
	csvData = csv.reader(open(csvFile, encoding = 'utf-8'), delimiter = fieldDelimiter)
	return csvData

def outputData(githubRepo, repoSubpath, database):
	httpPath = 'https://raw.githubusercontent.com/' + githubRepo + 'master/' + repoSubpath + database + '/'

	# must open the configuration/constants file separately in order to discover the core document and separator character
	csvData = getCsvObject('constants.csv', ',')
	
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
	tempCsvData = getCsvObject('constants.csv', ',')
	xmlFile = 'store\\' + 'constants.xml'
	writeGenericXml('constants', tempCsvData, xmlFile)
	
	# write each of the various associated files	
	nameList = generateFilenameList(coreDocRoot)
	for name in nameList:
		xmlFile = 'store\\' + name['name'] + '.xml'
		csvData = getCsvObject(name['name'] + '.csv', ',')
		writeGenericXml(name['tag'], csvData, xmlFile)
	
	# The main metadata file must be handled separately, since may have a non-standard file extension or delimiter
	xmlFile = 'store\\' + coreDocRoot + '.xml'
	csvData = getCsvObject(coreDocFileName, fieldDelimiter)
	writeGenericXml('metadata', csvData, xmlFile)
	
	# The linked class data has a different format and must be handled separately
	writeLinkedMetadataXml('store\\linked-classes.xml', fieldDelimiter)

def main():	
	outputData('HeardLibrary/semantic-web/', '2016-fall/', 'tang-song')

if __name__=="__main__":
	main()
