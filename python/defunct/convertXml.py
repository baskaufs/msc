# First row of the csv file must be header!

# example CSV file: myData.csv
# id,code name,value
# 36,abc,7.6
# 40,def,3.6
# 9,ghi,6.3
# 76,def,99

import csv
import codecs

def unicode_csv_reader(unicode_csv_data, dialect=csv.excel, **kwargs):
    # csv.py doesn't do Unicode; encode temporarily as UTF-8:
    csv_reader = csv.reader(utf_8_encoder(unicode_csv_data),
                            dialect=dialect, **kwargs)
    for row in csv_reader:
        # decode UTF-8 back to Unicode, cell by cell:
        yield [unicode(cell, 'utf-8') for cell in row]

def utf_8_encoder(unicode_csv_data):
    for line in unicode_csv_data:
        yield line.encode('utf-8')

csvFile = 'c:\github\guid-o-matic\\buildings-column-mappings.csv'
xmlFile = 'myData.xml'

#testData = open(csvFile)
#testData = 'id,code name,value\n36,abc,7.6\n40,def,3.6\n9,ghi,6.3\n76,def,99\n'
#csvData = unicode_csv_reader(testData)


csvData = csv.reader(open(csvFile))
xmlData = open(xmlFile, 'w')
xmlData.write('<?xml version="1.0"?>' + "\n")
# there must be only one top-level tag
xmlData.write('<metadata>' + "\n")

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
            xmlData.write('    ' + '<' + tags[i] + '>' \
                          + row[i] + '</' + tags[i] + '>' + "\n")
        xmlData.write('</record>' + "\n")
            
    rowNum +=1

xmlData.write('</metadata>' + "\n")
xmlData.close()

#if __name__=="__main__":
#	main()
