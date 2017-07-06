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
	uriBox = ttk.Entry(root, width = 100, textvariable = StringVar())
	uriBox.insert(END, 'http://vuswwg.jelastic.servint.net/gom/rest/test/junk.xml')
	commandBox = ttk.Entry(root, width = 120, textvariable = StringVar())
	commandBox.insert(END, '<xml><stuff>some stuff</stuff><stuff>more stuff</stuff></xml>')
	contentTypeBox = ttk.Entry(root, width = 50, textvariable = StringVar())
	contentTypeBox.insert(END, 'application/sparql-update')
	usernameBox = ttk.Entry(root, width = 10, textvariable = StringVar())
	usernameBox.insert(END, 'admin')
	passwordBox = ttk.Entry(root, width = 10, textvariable = StringVar())
	passwordBox.insert(END, '[pwd]')
	statusCode = ttk.Label(root, text = "status code goes here")
	responseBody = ttk.Label(root, text = "response body goes here")    
	def buttonClick():
		hdr = {'Content-Type' : contentTypeBox.get()}
		r = requests.put(uriBox.get(), auth=(usernameBox.get(), passwordBox.get()), data = commandBox.get() )
		#r = requests.delete(uriBox.get(), auth=(usernameBox.get(), passwordBox.get()) )
		statusCode.config(text = r.status_code)
		responseBody.config(text = r.text)
		# data = r.text
		# Note: rename=True is used because xml:lang is an invalid Python name.  It gets renamed to "_0" instead with this setting.
		# returnedJson = json.loads(data, object_hook=lambda d: namedtuple('X', d.keys(), rename=True)(*d.values()))
		# for i in range(number):
		# print(returnedJson.results.bindings[i].kind.value)
	goButton = ttk.Button(root, text = "Send command", width = 15, command = lambda: buttonClick() )
	uriBox.pack()
	commandBox.pack()
	contentTypeBox.pack()
	usernameBox.pack()
	passwordBox.pack()
	statusCode.pack()
	responseBody.pack()
	goButton.pack()
	root.mainloop()

if __name__=="__main__":
	main()
