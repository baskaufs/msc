import csv #library to read/write/parse CSV files
import math

aocCsv = open('c:\\Dropbox\\aoc.csv', "r") #don't forget that backslashes need to be escaped, default read open mode is text, not binary
aocData = csv.reader(aocCsv, delimiter='\t')  #delimiter in supplied spreadsheet was tab, in example was space

def findDivide(integerList):
	divisorList = integerList
	for i in range(len(integerList)):
		for j in range(len(divisorList)):
			division = integerList[i]/divisorList[j]
			if integerList[i] % divisorList[j]==0 and division!=1:
				return division

sum = 0
for row in aocData:
	for i in range(len(row)):
		row[i]=int(row[i]) # turn strings into integer numbers
	sum += findDivide(row)
print(sum)