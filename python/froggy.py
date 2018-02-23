# Steve Baskauf 2018-02-23 Freely available under a GNU GPLv3 license. 

#libraries for GUI interface
import tkinter
from tkinter import *
from tkinter import ttk

import RPi.GPIO as GPIO ## Import GPIO library
GPIO.setmode(GPIO.BOARD) ## Use board pin numbering
GPIO.setup(17, GPIO.OUT) ## Setup GPIO Pin 17 to OUT; tongue motor power
GPIO.setup(18, GPIO.OUT) ## tongue motor direction

root = Tk()

# this sets up the characteristics of the window
root.title("Froggy robot controller")
mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

#set up array of labels, text entry boxes, and buttons
outPinText = StringVar()
ttk.Label(mainframe, textvariable=outPinText).grid(column=3, row=2, sticky=(W, E))
outPinText.set('output pin number')
outPinBox = ttk.Entry(mainframe, width = 25, textvariable = StringVar())
outPinBox.grid(column=4, row=2, sticky=W)
outPinBox.insert(END, '17')

def offButtonClick():
	off(outPinBox.get())
gitToBaseButton = ttk.Button(mainframe, text = "off", width = 10, command = lambda: offButtonClick() )
gitToBaseButton.grid(column=3, row=4, sticky=W)

def onButtonClick():
	on(outPinBox.get())
gitToBaseButton = ttk.Button(mainframe, text = "on", width = 10, command = lambda: onButtonClick() )
gitToBaseButton.grid(column=4, row=4, sticky=W)

emptyText = StringVar()
ttk.Label(mainframe, textvariable=emptyText).grid(column=3, row=6, sticky=(W, E))
emptyText.set(' ')

def tongueOutButtonClick():
	tongueOut()
gitToBaseButton = ttk.Button(mainframe, text = "tongue out", width = 30, command = lambda: tongueOutButtonClick() )
gitToBaseButton.grid(column=4, row=8, sticky=W)

def tongueInButtonClick():
	tongueIn()
gitToBaseButton = ttk.Button(mainframe, text = "tongue in", width = 30, command = lambda: tongueInButtonClick() )
gitToBaseButton.grid(column=4, row=10, sticky=W)

def forwardButtonClick():
	forward()
baseToTripleButton = ttk.Button(mainframe, text = "forward", width = 30, command = lambda: forwardButtonClick() )
baseToTripleButton.grid(column=4, row=12, sticky=W)

def backwardButtonClick():
	backward()
moveFileButton = ttk.Button(mainframe, text = "backward", width = 30, command = lambda: backwardButtonClick() )
moveFileButton.grid(column=4, row=14, sticky=W)

def turnRightButtonClick():
	turnRight()
dropGraphButton = ttk.Button(mainframe, text = "turn right", width = 30, command = lambda: turnRightButtonClick() )
dropGraphButton.grid(column=4, row=16, sticky=W)

def turnLeftButtonClick():
	turnLeft()
dropGraphButton = ttk.Button(mainframe, text = "turn left", width = 30, command = lambda: turnLeftButtonClick() )
dropGraphButton.grid(column=4, row=18, sticky=W)

def on(pin):
	text = pin + ' on'
	GPIO.output(int(pin),True) ## Turn on GPIO pin
	print(text)

def off(pin):
	text = pin + ' off'
	GPIO.output(int(pin),False) ## Turn off GPIO pin
	print(text)

def tongueOut():
	print("tongue out")

def tongueIn():
	print("tongue in")

def forward():
	print("forward")

def backward():
	print("backward")

def turnRight():
	print("turn right")

def turnLeft():
	print("turn left")

def main():	
	root.mainloop()
	
if __name__=="__main__":
	main()
