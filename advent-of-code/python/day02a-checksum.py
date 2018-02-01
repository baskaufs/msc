import csv #library to read/write/parse CSV files

aocCsv = open('c:\\Dropbox\\aoc.csv', "r") #don't forget that backslashes need to be escaped, default read open mode is text, not binary
aocData = csv.reader(aocCsv, delimiter='\t')  #delimiter in supplied spreadsheet was tab, in example was space

sum = 0
for row in aocData:
	for i in range(len(row)):
		row[i]=int(row[i]) # turn strings into integer numbers
	sum += max(row)-min(row)
print(sum)