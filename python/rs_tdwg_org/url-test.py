import tkinter
from tkinter import *
from tkinter import ttk
import requests
import csv #library to read/write/parse CSV files

header = 'text/turtle'
csvObject = open('rs-not-404s.csv', newline='')
csvData = csv.reader(csvObject)
rowNum = 0

for row in csvData:
    if rowNum == 0:    # the first row has headers rather than grades
        # find which column contains the identifier and which column contains the grade
        for i in range(len(row)):
            print(row[i])
    rowNum =+ 1

#	uriBox.insert(END, 'https://sparql.vanderbilt.edu/sparql?query=SELECT%20DISTINCT%20%3Fclass%20WHERE%20%7B%0A%20%20%3Fresource%20a%20%3Fclass.%0A%20%20%7D%0ALIMIT%201')
#	acceptBox.insert(END, 'application/sparql-results+json')
#	statusCode = ttk.Label(root, text = "status code goes here")
#	responseBody = ttk.Label(root, text = "response body goes here")    

#		hdr = {'Accept' : header}
#		r = requests.get(uriBox.get(), headers=hdr)
#		statusCode.config(text = r.status_code)
#		responseBody.config(text = r.text)
#	goButton = ttk.Button(root, text = "Send GET", width = 8, command = lambda: buttonClick() )

