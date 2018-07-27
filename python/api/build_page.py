import http_library

#url = 'https://api.flickr.com/services/rest/?method=flickr.people.getPhotos&extras=license,media,original_format,description,date_taken,geo,tags,machine_tags,url_t,url_o&per_page=10&page=1&user_id=32005048@N06&oauth_consumer_key=[key]'
#url = 'http://api.gbif.org/v1/occurrence/search?recordedBy=William%20A.%20Haber&offset=0&limit=3'
url = 'https://raw.githubusercontent.com/tdwg/rs.tdwg.org/master/audubon-versions/audubon-versions.csv'
accept = 'csv'  # options are csv or json (xml not yet implemented)
param1 = ','  # for csv use delimiter, for json use key of data array
table = http_library.retrieveData(url, accept, param1)

headerFileName = 'termlist-header.md'
footerFileName = 'termlist-footer.md'
outFileName = 'ac-test.md'
namespaceAbbreviation = 'ac:'
namespaceUri = 'http://rs.tdwg.org/ac/terms/'
header = table[0]

# determine which column contains the specified metadata field
for column in range(len(header)):
    if header[column] == 'term_localName':
        localNameColumn = column
    if header[column] == 'label':
        labelColumn = column
    if header[column] == 'tdwgutility_layer':
        layerColumn = column
    if header[column] == 'tdwgutility_required':
        requiredColumn = column
    if header[column] == 'tdwgutility_repeatable':
        repeatableColumn = column
    if header[column] == 'rdfs_comment':
        definitionColumn = column
    if header[column] == 'dcterms_description':
        notesColumn = column

text = ''
text += '| property | value |\n'
text += '|----------|-------|\n'
for row in table:
    text += '| **Term Name:** | **' + namespaceAbbreviation + row[localNameColumn] + '** |\n'
    text += '| Normative URI: | ' + namespaceUri + row[localNameColumn] + ' |\n'
    text += '| Label: | ' + row[labelColumn] + ' |\n'
    text += '| | **Layer:** ' + row[layerColumn] + ' -- **Required:** ' + row[requiredColumn] + ' -- **Repeatable:** ' + row[repeatableColumn] + ' |\n'
    text += '| Definition: | ' + row[definitionColumn] + ' |\n'
    text += '| Notes: | ' + row[notesColumn] + ' |\n'
    text += '| | |\n'
text += '| | |\n'

headerObject = open(headerFileName, 'rt')
header = headerObject.read()
headerObject.close()

footerObject = open(footerFileName, 'rt')
footer = footerObject.read()
footerObject.close()

outputObject = open(outFileName, 'wt')
outputObject.write(header + text + footer)
outputObject.close()