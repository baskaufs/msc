import csv        # library to read/write/parse CSV files
import re         # regex library

def fixTaxa(fileName, plantsDict, tsnSet):
    fileObject = open('output/' + fileName, 'rt')
    lines = fileObject.readlines()
    fileObject.close()
    
    outputString = ''
    startPattern = 'href="../species/'
    endPattern = '.htm"'
    errorList = []
    
    for line in lines:
        if line.count(startPattern) == 1:
            firstPart = line[:line.find(startPattern)] + 'href="../tsn/'
            beginUsdaCode = line.find(startPattern) + 17
            remainder = line[beginUsdaCode:]
            endUsdaCode = remainder.find(endPattern)
            lastPart = remainder[endUsdaCode:]
            usdaCode = line[beginUsdaCode:beginUsdaCode + endUsdaCode]
            itisTsn = plantsDict.get(usdaCode,'missingUsda')
            if itisTsn in tsnSet:
                outputString += firstPart + itisTsn + lastPart
            else:  # the TSN is not one for which Bioimages has minted a URI
                outputString += firstPart + '__' + itisTsn + lastPart
                errorList.append([fileName, itisTsn])
        else:
            outputString += line
    outObject = open('output/' + fileName, 'wt')
    outObject.write(outputString)
    outObject.close()
    return errorList

pageFile = 'pagefile.txt'
fileListObject = open(pageFile, 'rt', newline='')
fileList = csv.reader(fileListObject)

plantsObject = open('plants-usda-all.csv', 'rt', newline='')
plantsDict = dict(csv.reader(plantsObject)) # each row in the reader object is a list of strings. dict() converts the first item in the list to the key and the second to the value 
plantsObject.close()

tsnObject = open('tsn.txt','rt', newline='')
tsnReader = csv.reader(tsnObject)
tsnList = []
for row in tsnReader:
    tsnList.append(row[0])
tsnObject.close()
tsnSet = set(tsnList)

errorList = []
for file in fileList:
    htmlFileName = file[0]
    htmlFileObject = open(htmlFileName, 'rt')
    html = htmlFileObject.read()
    html = re.sub('src="\.\./\w/w','src="../lq/baskauf/w',html)
    html = re.sub('src="\.\./\w/t','src="../tn/baskauf/t',html)
    html = re.sub('href="\.\./\w/w','href="../lq/baskauf/w',html)
    html = re.sub('"\.\./frame.htm">bioimages home','"../index.htm">Bioimages home',html)
    html = re.sub('<a href="http://www.worldwildlife.org/science/wildfinder/" target="_blank">WWF \nWildfinder home</a>','',html)
    html = re.sub('http://www.worldwildlife.org/wildworld/profiles/terrestrial/na/na','https://www.worldwildlife.org/ecoregions/na',html)
    html = re.sub('_full.html"','"',html)
    html = html.replace('<a target="reference" href="http://www.nationalgeographic.com/wildworld/profiles/terrestrial/na/na0402.html">View National Geographic WildWorld profile</a></font><font size="1">,(<a target="_top" href="http://www.nationalgeographic.com/wildworld/terrestrial.html">WildWorld ','')
    html = html.replace('home</a>),','')
    html = html.replace('View&nbsp;','')
    html = html.replace('<a target="reference" href="http://www.worldwildlife.org/wildfinder/searchByPlace.cfm?ecoregion=NA0402&orderBy=1&sortType=DESC#results">WWF Wildfinder animal species list</a> ','')
    html = html.replace('(<a target="_top" href="http://www.worldwildlife.org/wildfinder/searchByPlace.cfm">WildFinder ','')
    html = html.replace('home</a>)','')
    html = html.replace('<a target="reference" href="http://www.nationalgeographic.com/wildworld/profiles/terrestrial/na/na0416.html">National Geographic WildWorld profile</a></font><font size="1">,(<a target="_top" href="http://www.nationalgeographic.com/wildworld/terrestrial.html">WildWorld ','')
    html = html.replace('<a target="reference" href="http://www.worldwildlife.org/wildfinder/searchByPlace.cfm?ecoregion=NA0416&orderBy=1&sortType=DESC#results">WWF Wildfinder animal species list</a>','')
    html = html.replace('\nView','')
    html = html.replace('target="reference" href="https://www.worldwildlife.org/ecoregions/','target="_top" href="https://www.worldwildlife.org/ecoregions/')
    html = html.replace('animals/mammalia/w','lq/baskauf/w')
    html = html.replace('animals/mammalia/t','tn/baskauf/t')
    html = html.replace('target="reference">\necoregion','target="_top">\necoregion')
    outFileObject = open('output/' + htmlFileName, 'wt')
    outFileObject.write(html)
    outFileObject.close()
    errorList += fixTaxa(htmlFileName, plantsDict, tsnSet)  # the function returns a list of [filename, badTsn] lists.
print(errorList)
    