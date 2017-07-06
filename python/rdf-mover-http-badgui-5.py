# XML creation functions hacked from http://code.activestate.com/recipes/577423-convert-csv-to-xml/

#libraries for GUI interface
import tkinter
from tkinter import *
from tkinter import ttk
import tkinter.scrolledtext as tkst

import csv #library to read/write/parse CSV files
import requests #library to do HTTP communication

root = Tk()
root.title("HTTP communicator")
basexUriBox = ttk.Entry(root, width = 50, textvariable = StringVar())
basexUriBox.insert(END, 'http://vuswwg.jelastic.servint.net/gom/rest/')
githubRepoBox = ttk.Entry(root, width = 25, textvariable = StringVar())
githubRepoBox.insert(END, 'VandyVRC/tcadrt/')
repoSubpathBox = ttk.Entry(root, width = 25, textvariable = StringVar())
repoSubpathBox.insert(END, '')
databaseBox = ttk.Entry(root, width = 20, textvariable = StringVar())
databaseBox.insert(END, 'building')
passwordBox = ttk.Entry(root, width = 15, textvariable = StringVar())
passwordBox.insert(END, '[pwd]')
def gitToBaseButtonClick():
	dataToBasex(githubRepoBox.get(), repoSubpathBox.get(), databaseBox.get(), basexUriBox.get(), passwordBox.get())
gitToBaseButton = ttk.Button(root, text = "Transfer from Github to BaseX", width = 30, command = lambda: gitToBaseButtonClick() )
dumpUriBox = ttk.Entry(root, width = 50, textvariable = StringVar())
dumpUriBox.insert(END, 'http://vuswwg.jelastic.servint.net/gom/dump/')
endpointUriBox = ttk.Entry(root, width = 50, textvariable = StringVar())
endpointUriBox.insert(END, 'https://sparql.vanderbilt.edu/sparql')
graphNameBox = ttk.Entry(root, width = 50, textvariable = StringVar())
graphNameBox.insert(END, 'http://example.org/building')
passwordBox2 = ttk.Entry(root, width = 15, textvariable = StringVar())
passwordBox2.insert(END, '[pwd]')
def baseToTripleButtonClick():
	dataToTriplestore(dumpUriBox.get(), databaseBox.get(), endpointUriBox.get(), graphNameBox.get(), passwordBox2.get())
baseToTripleButton = ttk.Button(root, text = "Transfer from BaseX to Triplestore", width = 30, command = lambda: baseToTripleButtonClick() )
def dropGraphButtonClick():
	dropGraph(endpointUriBox.get(), graphNameBox.get(), passwordBox2.get())
dropGraphButton = ttk.Button(root, text = "Drop graph", width = 30, command = lambda: dropGraphButtonClick() )

labelText=StringVar()
labelText.set("Github repo path and subpath")
labelDir=Label(textvariable=labelText)
labelDir.pack()
githubRepoBox.pack()
repoSubpathBox.pack()

labelText=StringVar()
labelText.set("Database name")
labelDir=Label(textvariable=labelText)
labelDir.pack()
databaseBox.pack()

labelText=StringVar()
labelText.set("BaseX REST API URI root")
labelDir=Label(textvariable=labelText)
labelDir.pack()
basexUriBox.pack()

labelText=StringVar()
labelText.set("BaseX database password")
labelDir=Label(textvariable=labelText)
labelDir.pack()
passwordBox.pack()

gitToBaseButton.pack()

labelText=StringVar()
labelText.set("Graph dump URI root")
labelDir=Label(textvariable=labelText)
labelDir.pack()
dumpUriBox.pack()

labelText=StringVar()
labelText.set("SPARQL endpoint URI")
labelDir=Label(textvariable=labelText)
labelDir.pack()
endpointUriBox.pack()

labelText=StringVar()
labelText.set("Endpoint password")
labelDir=Label(textvariable=labelText)
labelDir.pack()
passwordBox2.pack()

labelText=StringVar()
labelText.set("Graph name")
labelDir=Label(textvariable=labelText)
labelDir.pack()
graphNameBox.pack()

baseToTripleButton.pack()
dropGraphButton.pack()

#scrolling text box hacked from https://www.daniweb.com/programming/software-development/code/492625/exploring-tkinter-s-scrolledtext-widget-python
frame = ttk.Frame(root)
frame.pack(fill='both', expand='yes')
edit_space = tkst.ScrolledText(master = frame, width  = 100, height = 25)
# the padx/pady space will form a frame
edit_space.pack(fill='both', expand=True, padx=8, pady=8)
edit_space.insert(END, '')
def updateLog(message):
	edit_space.insert(END, message + '\n')


def generateFilenameList(coreDoc):
	#does not include linked-metadata.csv, which must be processed differently
	filenameList = [{'name': 'namespace','tag': 'namespaces'},{'name': coreDoc + '-column-mappings','tag': 'column-index'},{'name': coreDoc + '-classes','tag': 'base-classes'}]
	return filenameList

def getCsvObject(httpPath, fileName, fieldDelimiter):
	# option to retrieve remotely from GitHub
	uri = httpPath + fileName
	r = requests.get(uri)
	updateLog(str(r.status_code) + ' ' + uri)
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
	updateLog(str(r.status_code) + ' ' + uri + '\n')
	print(str(r.status_code) + ' ' + uri)
	updateLog(r.text + '\n')
	print(r.text)

def dataToBasex(githubRepo, repoSubpath, database, basexServerUri, pwd):
	databaseWritePath = basexServerUri + database

	# first must do a PUT to the database URI to create it if it doesn't exist
	r = requests.put(databaseWritePath, auth=('admin', pwd) )
	updateLog('create XML database')
	print('create XML database')
	updateLog(str(r.status_code) + ' ' + databaseWritePath + '\n')
	print(str(r.status_code) + ' ' + databaseWritePath)

	httpReadPath = 'https://raw.githubusercontent.com/' + githubRepo + 'master/' + repoSubpath + database + '/'
	# must open the configuration/constants file separately in order to discover the core document and separator character
	updateLog('read constants')
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
	updateLog('read configuration')
	print('read configuration')
	tempCsvData = getCsvObject(httpReadPath, 'constants.csv', ',')
	body = '<?xml version="1.0" encoding="UTF-8" ?>' + '\n' + buildGenericXml('constants', tempCsvData)
	updateLog('write configuration')
	print('write configuration')
	writeDatabaseFile(databaseWritePath, 'constants.xml', body, pwd)
	
	# write each of the various associated files	
	nameList = generateFilenameList(coreDocRoot)
	for name in nameList:
		updateLog('read file')
		print('read file')
		csvData = getCsvObject(httpReadPath, name['name'] + '.csv', ',')
		body = '<?xml version="1.0" encoding="UTF-8" ?>' + '\n' + buildGenericXml(name['tag'], csvData)
		updateLog('write file')
		print('write file')
		writeDatabaseFile(databaseWritePath, name['name'] + '.xml', body, pwd)
	
	# The main metadata file must be handled separately, since may have a non-standard file extension or delimiter
	updateLog('read core metadata')
	print('read core metadata')
	csvData = getCsvObject(httpReadPath, coreDocFileName, fieldDelimiter)
	body = '<?xml version="1.0" encoding="UTF-8" ?>' + '\n' + buildGenericXml('metadata', csvData)
	updateLog('write core metadata')
	print('write core metadata')
	writeDatabaseFile(databaseWritePath, coreDocRoot + '.xml', body, pwd)
	
	# The linked class data has a different format and must be handled separately
	updateLog('read linked metadata')
	print('read linked metadata')
	csvData = getCsvObject(httpReadPath, 'linked-classes.csv', ',')
	body = buildLinkedMetadataXml(httpReadPath, csvData, fieldDelimiter)
	updateLog('write linked metadata')
	print('write linked metadata')
	writeDatabaseFile(databaseWritePath, 'linked-classes.xml', body, pwd)

def dataToTriplestore(dumpUri, database, endpointUri, graphName, pwd):
	updateCommand = 'LOAD <' + dumpUri + database + '> INTO GRAPH <' + graphName + '>'

	updateLog('update SPARQL endpoint into graph ' + graphName)
	print('update SPARQL endpoint into graph ' + graphName)
	
	# SPARQL Update requires HTTP POST
	hdr = {'Content-Type' : 'application/sparql-update'}
	r = requests.post(endpointUri, auth=('admin', pwd), headers=hdr, data = updateCommand)
	updateLog(str(r.status_code) + ' ' + r.url + '\n')
	print(str(r.status_code) + ' ' + r.url)
	updateLog(r.text + '\n')
	print(r.text)

def dropGraph(endpointUri, graphName, pwd):
	updateCommand = 'DROP GRAPH <' + graphName + '>'

	updateLog('drop graph ' + graphName)
	print('drop graph ' + graphName)
	
	# SPARQL Update requires HTTP POST
	hdr = {'Content-Type' : 'application/sparql-update'}
	r = requests.post(endpointUri, auth=('admin', pwd), headers=hdr, data = updateCommand)
	updateLog(str(r.status_code) + ' ' + r.url + '\n')
	print(str(r.status_code) + ' ' + r.url)
	updateLog(r.text + '\n')
	print(r.text)

def main():	
	#root = Tk()
	#root.title("HTTP communicator")
	#basexUriBox = ttk.Entry(root, width = 50, textvariable = StringVar())
	#basexUriBox.insert(END, 'http://vuswwg.jelastic.servint.net/gom/rest/')
	#githubRepoBox = ttk.Entry(root, width = 25, textvariable = StringVar())
	#githubRepoBox.insert(END, 'VandyVRC/tcadrt/')
	#repoSubpathBox = ttk.Entry(root, width = 25, textvariable = StringVar())
	#repoSubpathBox.insert(END, '')
	#databaseBox = ttk.Entry(root, width = 20, textvariable = StringVar())
	#databaseBox.insert(END, 'building')
	#passwordBox = ttk.Entry(root, width = 15, textvariable = StringVar())
	#passwordBox.insert(END, '[pwd]')

	#statusCode = ttk.Label(root, text = "status code goes here")
	#responseBody = ttk.Label(root, text = "response body goes here")    
	#def buttonClick():
	#	dataToBasex(githubRepoBox.get(), repoSubpathBox.get(), databaseBox.get(), basexUriBox.get(), passwordBox.get())
	#goButton = ttk.Button(root, text = "Transfer data", width = 20, command = lambda: buttonClick() )
	#githubRepoBox.pack()
	#repoSubpathBox.pack()
	#databaseBox.pack()
	#basexUriBox.pack()
	#passwordBox.pack()
		#statusCode.pack()
		#responseBody.pack()
	#goButton.pack()
	
	#frame = ttk.Frame(root)
	#frame.pack(fill='both', expand='yes')
	#edit_space = tkst.ScrolledText(master = frame, width  = 100, height = 50)
	# the padx/pady space will form a frame
	#edit_space.pack(fill='both', expand=True, padx=8, pady=8)
	#edit_space.insert(END, 'activity log goes here')
	#def updateLog(message):
	#	edit_space.insert(END, message)
	root.mainloop()
	
	
	# dataToBasex('HeardLibrary/semantic-web/', '2016-fall/', 'tang-song', 'http://vuswwg.jelastic.servint.net/gom/rest/', '[pwd]')
	# dataToBasex('VandyVRC/tcadrt/', '', 'building', 'http://vuswwg.jelastic.servint.net/gom/rest/', '[pwd]')

if __name__=="__main__":
	main()
