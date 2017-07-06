import csv
import codecs

csvFile = 'c:\github\guid-o-matic\\buildings.csv'
xmlFile = 'myData.xml'

#testData = 'id,code name,value\n36,abc,7.6\n40,def,3.6\n9,ghi,6.3\n76,def,99\n'
#csvData = unicode_csv_reader(testData)

fileObj = codecs.open( csvFile, "r", "utf-8" )
u = fileObj.read() # Returns a Unicode string from the UTF-8 bytes in the file

rowNum = 0
for row in u:
	print(row)
	rowNum +=1
