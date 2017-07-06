# XML creation functions hacked from http://code.activestate.com/recipes/577423-convert-csv-to-xml/

# TODO Assumes that the core metadata file and linked metadata docs have the extension .csv Need to relax that assumption.
# TODO Assumes that the core and linked docs use commas as separators, don't know if csv library functions support alternatives.

import csv

def generateFilenameList(coreDoc):
	#does not include linked-metadata.csv, which must be processed differently
	filenameList = [{'name': coreDoc + '-column-mappings','tag': 'column-index'},{'name': 'namespace','tag': 'namespaces'},{'name': coreDoc + '-classes','tag': 'base-classes'},{'name': coreDoc,'tag': 'metadata'}]
	return filenameList

def writeXmlFromString(rootElementName, csvData, xmlFile):
	xmlData = open(xmlFile, 'w', encoding = 'utf-8')
	xmlData.write('<?xml version="1.0"?>' + "\n")
	xmlString = buildXml(rootElementName, csvData)
	xmlData.write(xmlString)
	xmlData.close()

def writeXml(rootElementName, csvData, xmlFile):
	xmlData = open(xmlFile, 'w', encoding = 'utf-8')
	xmlData.write('<?xml version="1.0"?>' + "\n")
	# there must be only one top-level tag
	xmlData.write('<' + rootElementName + '>' + "\n")
	
	rowNum = 0
	for row in csvData:
		if rowNum == 0:
			tags = row
			# replace spaces w/ underscores in tag names
			for i in range(len(tags)):
				tags[i] = tags[i].replace(' ', '_')
		else: 
			xmlData.write('<record>' + "\n")
			for i in range(len(tags)):
				xmlData.write('    ' + '<' + tags[i] + '>' + row[i] + '</' + tags[i] + '>' + "\n")
			xmlData.write('</record>' + "\n")
		rowNum +=1
	
	xmlData.write('</' + rootElementName + '>' + "\n")
	xmlData.close()

def buildXml(rootElementName, csvData):
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
	
def constructLinkedMetadataXml():
	csvFile = 'c:\github\guid-o-matic\\linked-classes.csv'
	csvData = csv.reader(open(csvFile, encoding = 'utf-8'))
	xmlData = ''
	xmlData = xmlData + '<linked-metadata>' + "\n"
	
	# tags = csvData[0]
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
			csvSubData = csv.reader(open('c:\github\guid-o-matic\\' + fileNameRoot + '-classes.csv', encoding = 'utf-8'))
			xmlData = xmlData + buildXml('classes', csvSubData)
			csvSubData = csv.reader(open('c:\github\guid-o-matic\\' + fileNameRoot + '-column-mappings.csv', encoding = 'utf-8'))
			xmlData = xmlData + buildXml('mapping', csvSubData)
			csvSubData = csv.reader(open('c:\github\guid-o-matic\\' + fileName, encoding = 'utf-8'))
			xmlData = xmlData + buildXml('metadata', csvSubData)
			
			xmlData = xmlData + '</file>' + "\n"
		rowNum +=1
	
	xmlData = xmlData + '</linked-metadata>' + "\n"
	return xmlData

def testFileOutput():
	coreDoc = 'site'
	nameList = generateFilenameList(coreDoc)
	for name in nameList:
		csvFile = 'c:\github\guid-o-matic\\' + name['name'] + '.csv'
		xmlFile = 'store\\' + name['name'] + '.xml'
		csvData = csv.reader(open(csvFile, encoding = 'utf-8'))
		writeXmlFromString(name['tag'], csvData, xmlFile)

def main():	
	# tempXml = '<?xml version="1.0"?>' + "\n" + buildXml('metadata', csvData)
	# print(buildXml('metadata', csvData))
	testFileOutput()
	# print(constructLinkedMetadataXml())

if __name__=="__main__":
	main()
