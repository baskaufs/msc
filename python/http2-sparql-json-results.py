import tkinter
from tkinter import *
from tkinter import ttk
import requests
import json
from collections import namedtuple

def main():
	number = 10
	numberString = str(number)
	root = Tk()
	root.title("HTTP communicator")
	uriBox = ttk.Entry(root, width = 175, textvariable = StringVar())
	uriBox.insert(END, 'https://sparql.vanderbilt.edu/sparql?query=SELECT%20DISTINCT%20%3Fkind%20WHERE%20%7B%0A%20%20%3Fresource%20a%20%3Fkind.%0A%20%20%7D%0ALIMIT%20' + numberString)
	acceptBox = ttk.Entry(root, width = 50, textvariable = StringVar())
	acceptBox.insert(END, 'application/sparql-results+json')
	statusCode = ttk.Label(root, text = "status code goes here")
	responseBody = ttk.Label(root, text = "response body goes here")    
	def buttonClick():
		hdr = {'Accept' : acceptBox.get()}
		r = requests.get(uriBox.get(), headers=hdr)
		statusCode.config(text = r.status_code)
		responseBody.config(text = r.text)
		data = r.text
		# Note: rename=True is used because xml:lang is an invalid Python name.  It gets renamed to "_0" instead with this setting.
		returnedJson = json.loads(data, object_hook=lambda d: namedtuple('X', d.keys(), rename=True)(*d.values()))
		for i in range(number):
			print(returnedJson.results.bindings[i].kind.value)
	goButton = ttk.Button(root, text = "Send GET", width = 8, command = lambda: buttonClick() )
	uriBox.pack()
	acceptBox.pack()
	statusCode.pack()
	responseBody.pack()
	goButton.pack()
	root.mainloop()

if __name__=="__main__":
	main()
