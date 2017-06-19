import tkinter
from tkinter import *
from tkinter import ttk


def main():
	root = Tk()
	root.title("HTTP communicator")
	uriBox = ttk.Entry(root, width = 100, textvariable = StringVar())
	statusCode = ttk.Label(root, text = "code")
	responseBody = ttk.Label(root, text = "hello")    
	#frame = ttk.Frame(root)
	#goButton = ttk.Button(frame, text = "Send GET", width = 8)
	def buttonClick(words):
		responseBody.config(text = words)
	goButton = ttk.Button(root, text = "Send GET", width = 8, command = lambda i=uriBox.get(): buttonClick(i) )
	uriBox.pack()
	statusCode.pack()
	responseBody.pack()
	goButton.pack()
	root.mainloop()

if __name__=="__main__":
	main()