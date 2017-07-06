import tkinter
from tkinter import *
from tkinter import ttk
import requests

def main():
	root = Tk()
	root.title("HTTP communicator")
	uriBox = ttk.Entry(root, width = 175, textvariable = StringVar())
	uriBox.insert(END, 'https://sparql.vanderbilt.edu/sparql?query=SELECT%20DISTINCT%20%3Fclass%20WHERE%20%7B%0A%20%20%3Fresource%20a%20%3Fclass.%0A%20%20%7D%0ALIMIT%201')
	acceptBox = ttk.Entry(root, width = 50, textvariable = StringVar())
	acceptBox.insert(END, 'application/sparql-results+json')
	statusCode = ttk.Label(root, text = "status code goes here")
	responseBody = ttk.Label(root, text = "response body goes here")    
	def buttonClick():
		hdr = {'Accept' : acceptBox.get()}
		r = requests.get(uriBox.get(), headers=hdr)
		statusCode.config(text = r.status_code)
		responseBody.config(text = r.text)
	goButton = ttk.Button(root, text = "Send GET", width = 8, command = lambda: buttonClick() )
	uriBox.pack()
	acceptBox.pack()
	statusCode.pack()
	responseBody.pack()
	goButton.pack()
	root.mainloop()

if __name__=="__main__":
	main()
