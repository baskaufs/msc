# Script to build the Audubon Core term list page using Markdown.
# Steve Baskauf 2018-06-20
# Updated 2020-01-28
# This script merges static Markdown header and footer documents with term information tables (in Markdown) generated from data in the rs.tdwg.org repo from the TDWG Github site

# Note: this script calls a function from http_library.py, which requires importing the requests, csv, and json modules
import http_library
import re

# ---------------------------------------------------------------------------
# retrieve vocabularies members metadata from Github
def retrieveVocabularyInfo(githubBaseUri):
    dataUrl = githubBaseUri + 'vocabularies/vocabularies-members.csv'
    table = http_library.retrieveData(dataUrl, 'csv', ',')
    #print(table[0])
    header = table[0]

    # determine which column contains the vocab and term list ids
    for column in range(len(header)):
        if header[column] == 'termList':
            termListColumn = column
        if header[column] == 'vocabulary':
            vocabularyColumn = column

    # store the identifiers of the term lists
    termLists = []
    for row in range(1,len(table)):    #skip the header row
        if table[row][vocabularyColumn] == 'http://rs.tdwg.org/dwc/':
            termLists.append(table[row][termListColumn])
    return termLists

# ---------------------------------------------------------------------------
# create dictionaries of metadata about term lists
def retrieveTermListMetadata(githubBaseUri):
    # retrieve term list metadata from Github
    dataUrl = githubBaseUri + 'term-lists/term-lists.csv'
    table = http_library.retrieveData(dataUrl, 'csv', ',')
    header = table[0]

    # determine which columns contain the namespace info
    for column in range(len(header)):
        if header[column] == 'list':
            listColumn = column
        if header[column] == 'vann_preferredNamespacePrefix':
            prefixColumn = column
        if header[column] == 'vann_preferredNamespaceUri':
            uriColumn = column

    listFilename = {}
    listNamespace = {}
    listUri = {}

    for row in range(1,len(table)):    #skip the header row
        for termList in termLists:
            if termList == table[row][listColumn]:
                listNamespace[termList] = table[row][prefixColumn] # make a dictionary of namespaces
                listUri[termList] = table[row][uriColumn] # make a dictionary of URIs
                if table[row][prefixColumn] == 'dwcdoe':
                    listFilename[termList] = 'degreeOfEstablishment'
                else:
                    listFilename[termList] = table[row][prefixColumn] + '-for-ac' # make a dictionary of filenames
    return [listFilename, listNamespace, listUri]
# ---------------------------------------------------------------------------
# create a single table that combines all relevant metadata from the various term list metadata tables
def createMasterMetadataTable(termLists, listMetadata):
    fileNameDict = listMetadata[0]
    namespaceDict = listMetadata[1]
    uriDict = listMetadata[2]
    masterTable = []

    for termList in termLists:
        # retrieve term metadata for a particular list from Github
        dataUrl = githubBaseUri + fileNameDict[termList] + '/' + fileNameDict[termList] + '.csv'
        table = http_library.retrieveData(dataUrl, 'csv', ',')
        header = table[0]

        # determine which columns contain specified metadata fields
        for column in range(len(header)):
            if header[column] == 'term_localName':
                localNameColumn = column
            if header[column] == 'label':
                labelColumn = column
            if header[column] == 'definition':
                definitionColumn = column
            if header[column] == 'usage':
                scopeNoteColumn = column
            if header[column] == 'notes':
                notesColumn = column
            if header[column] == 'rdf_value':
                valueColumn = column

        for row in range(1,len(table)):    #skip the header row
            masterTable.append([ namespaceDict[termList], uriDict[termList], table[row][localNameColumn], table[row][labelColumn], table[row][definitionColumn], table[row][scopeNoteColumn], table[row][notesColumn], table[row][valueColumn] ])

    return masterTable

# ---------------------------------------------------------------------------
# generate the index of terms grouped by category and sorted alphabetically by lowercase term local name
def buildIndexByTermName(table, displayOrder, displayLabel, displayId):

    text = '### 6.1 Index By Term Name\n\n'
    text += '(See also [6.2 Index By Label](#62-index-by-label))\n\n'
    for category in range(0,len(displayOrder)):
        text += '**' + displayLabel[category] + '**\n'
        text += '\n'
        filteredTable = [x for x in table if x[10] == displayOrder[category]]
        for row in range(0,len(filteredTable)):    #no header row
            curie = filteredTable[row][0] + ":" + filteredTable[row][2]
            curieAnchor = curie.replace(':','_')
            text += '[' + curie + '](#' + curieAnchor + ')'
            if row < len(filteredTable) - 1:
                text += ' |'
            text += '\n'
        text += '\n'
    return text

# ---------------------------------------------------------------------------
# generate the index of terms grouped by category and sorted alphabetically by the term label
def buildIndexByTermLabel(table, displayOrder, displayLabel, displayId):

    text = '### 6.2 Index By Label\n\n'
    text += '(See also [6.1 Index By Term Name](#61-index-by-term-name))\n\n'
    for category in range(0,len(displayOrder)):
        text += '**' + displayLabel[category] + '**\n'
        text += '\n'
        filteredTable = [x for x in table if x[10] == displayOrder[category]]
        for row in range(0,len(filteredTable)):    #no header row
            if row == 0 or (row != 0 and filteredTable[row][3] != filteredTable[row-1][3]): # this is a hack to prevent duplicate labels
                curieAnchor = filteredTable[row][0] + "_" + filteredTable[row][2]
                text += '[' + filteredTable[row][3] + '](#' + curieAnchor + ')'
                if row < len(filteredTable) - 2 or (row == len(filteredTable) -2 and filteredTable[row][3] != filteredTable[row + 1][3]):
                    text += ' |'
                text += '\n'
        text += '\n'
    return text

# ---------------------------------------------------------------------------
# generate a table for each term, with terms grouped by category
def buildMarkdown(table, displayOrder, displayLabel, displayComments, displayId):

    # generate the Markdown for the terms table
    text = '## 7 Vocabularies\n'
    for category in range(0,len(displayOrder)):
        text += '### 7.' + str(category + 1) + ' ' + displayLabel[category] + '\n'
        text += '\n'
        text += displayComments[category] # insert the comments for the category, if any.
        for row in range(0,len(table)):    #no header row
            if displayOrder[category] == table[row][10]:
                text += '<table>\n'
                curie = table[row][0] + ":" + table[row][2]
                curieAnchor = curie.replace(':','_')
                text += '\t<thead>\n'
                text += '\t\t<tr>\n'
                text += '\t\t\t<th colspan="2"><a id="' + curieAnchor + '"></a>Term Name: ' + curie + '</th>\n'
                text += '\t\t</tr>\n'
                text += '\t</thead>\n'
                text += '\t<tbody>\n'
                text += '\t\t<tr>\n'
                text += '\t\t\t<td>Normative URI:</td>\n'
                uri = table[row][1] + table[row][2]
                text += '\t\t\t<td><a href="' + uri + '">' + uri + '</a></td>\n'
                text += '\t\t</tr>\n'
                text += '\t\t<tr>\n'
                text += '\t\t\t<td>Label</td>\n'
                text += '\t\t\t<td>' + table[row][3] + '</td>\n'
                text += '\t\t</tr>\n'
                text += '\t\t<tr>\n'
                text += '\t\t\t<td></td>\n'
                text += '\t\t\t<td><b>Required:</b> ' + table[row][5] + ' -- <b>Repeatable:</b> ' + table[row][6] + '</td>\n'
                text += '\t\t</tr>\n'
                text += '\t\t<tr>\n'
                text += '\t\t\t<td>Definition</td>\n'
                text += '\t\t\t<td>' + table[row][7] + '</td>\n'
                text += '\t\t</tr>\n'
                if table[row][8] != '':
                    text += '\t\t<tr>\n'
                    text += '\t\t\t<td>Usage</td>\n'
                    text += '\t\t\t<td>' + createLinks(table[row][8]) + '</td>\n'
                    #text += '\t\t\t<td>' + table[row][8] + '</td>\n'
                    text += '\t\t</tr>\n'
                if table[row][9] != '':
                    text += '\t\t<tr>\n'
                    text += '\t\t\t<td>Notes</td>\n'
                    text += '\t\t\t<td>' + createLinks(table[row][9]) + '</td>\n'
                    #text += '\t\t\t<td>' + table[row][9] + '</td>\n'
                    text += '\t\t</tr>\n'
                text += '\t</tbody>\n'
                text += '</table>\n'
                text += '\n'
        text += '\n'
    return text
# ---------------------------------------------------------------------------
# replace URL with link
#
def createLinks(text):
    def repl(match):
        if match.group(1)[-1] == '.':
            return '<a href="' + match.group(1)[:-1] + '">' + match.group(1)[:-1] + '</a>.'
        return '<a href="' + match.group(1) + '">' + match.group(1) + '</a>'

    pattern = '(https?://[^\s,;\)"]*)'
    result = re.sub(pattern, repl, text)
    return result

# ---------------------------------------------------------------------------
# read in header and footer, merge with terms table, and output
def outputMarkdown(text, headerFileName, footerFileName, outFileName):
    headerObject = open(headerFileName, 'rt', encoding='utf-8')
    header = headerObject.read()
    headerObject.close()

    footerObject = open(footerFileName, 'rt', encoding='utf-8')
    footer = footerObject.read()
    footerObject.close()

    output = header + text + footer
    outputObject = open(outFileName, 'wt', encoding='utf-8')
    outputObject.write(output)
    outputObject.close()

# ---------------------------------------------------------------------------
# main routine

# constants
githubBaseUri = 'https://raw.githubusercontent.com/tdwg/rs.tdwg.org/cv/'
headerFileName = 'termlist-header.md'
footerFileName = 'termlist-footer.md'
outFileName = '../docs/termlist.md'

displayOrder = ['http://rs.tdwg.org/dwc/terms/attributes/Management']
displayLabel = ['Vocabulary']
displayComments = ['']
displayId = ['Vocabulary']

termLists = retrieveVocabularyInfo(githubBaseUri)

listMetadata = retrieveTermListMetadata(githubBaseUri)

table = createMasterMetadataTable(termLists, listMetadata)

localnameSortedTable = sorted(table, key = lambda term: term[2].lower() ) # perform sort on lowercase of the third column: localNameColumn
labelSortedTable = sorted(table, key = lambda term: term[3].lower() ) # perform sort on lowercase of the fourth column: labelColumn

indexByName = buildIndexByTermName(localnameSortedTable, displayOrder, displayLabel, displayId)
indexByLabel = buildIndexByTermLabel(labelSortedTable, displayOrder, displayLabel, displayId)
termTable = buildMarkdown(localnameSortedTable, displayOrder, displayLabel, displayComments, displayId)

text = indexByName + indexByLabel + termTable

outputMarkdown(text, headerFileName, footerFileName, outFileName)
