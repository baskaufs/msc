# Steve Baskauf 2017-10-07 Freely available under a GNU GPLv3 license. 
# Script to convert downloaded grade files from TopHat into CSV files suitable for upload to Brightspace 

#libraries for GUI interface
import tkinter
from tkinter import *
from tkinter import ttk
import tkinter.scrolledtext as tkst

import csv #library to read/write/parse CSV files

# ------------------------------------------------------------------------------------------
# Implementation-specific values

# Set the value of the label for the column in the TopHat input file that contains the TopHat email identifier.
topHatInputEmailIdLabel = "email"

# Set the value of the label for the column in the VUnetID/Brightspace Email mapping file that contains the VUnet ID. 
# The label provided by Online Grading is "VUnetID".
userIdLabel = "VUnetID"

# Set the value of the label in the Brightspace upload file for the column containing the VUnet ID.
brightspaceUserIdLabel = "OrgDefinedId"

# Set the value of the label in the Brightspace upload file for the column containing the username (also the VUnet ID).
brightspaceUsernameLabel = " Username"

# ------------------------------------------------------------------------------------------
# User interface setup

# this sets up the characteristics of the window
root = Tk()
root.title("TopHat to Brightspace grade mover")
mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

#set up array of labels, text entry boxes, and buttons
topHatPathPrefix = StringVar()
ttk.Label(mainframe, textvariable=topHatPathPrefix).grid(column=3, row=3, sticky=(W, E))
topHatPathPrefix.set('TopHat input file prefix')
topHatPathPrefixBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
topHatPathPrefixBox.grid(column=4, row=3, sticky=W)
topHatPathPrefixBox.insert(END, 'c:\github\msc\python\grade-mover\section-')

topHatPathSuffix = StringVar()
ttk.Label(mainframe, textvariable=topHatPathSuffix).grid(column=3, row=4, sticky=(W, E))
topHatPathSuffix.set('TopHat input file suffix')
topHatPathSuffixBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
topHatPathSuffixBox.grid(column=4, row=4, sticky=W)
topHatPathSuffixBox.insert(END, '-tophat-grades.csv')

topHatInputGradeLabel = StringVar()
ttk.Label(mainframe, textvariable=topHatInputGradeLabel).grid(column=3, row=5, sticky=(W, E))
topHatInputGradeLabel.set('Label for grade ave. in input file')
topHatInputGradeLabelBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
topHatInputGradeLabelBox.grid(column=4, row=5, sticky=W)
topHatInputGradeLabelBox.insert(END, 'total_grade')

emptyText = StringVar()
ttk.Label(mainframe, textvariable=emptyText).grid(column=3, row=6, sticky=(W, E))
emptyText.set(' ')

vunetIdBrightspaceEmailLinks = StringVar()
ttk.Label(mainframe, textvariable=vunetIdBrightspaceEmailLinks).grid(column=3, row=7, sticky=(W, E))
vunetIdBrightspaceEmailLinks.set('VUnetID/Brightspace Email mapping file')
vunetIdBrightspaceEmailLinksBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
vunetIdBrightspaceEmailLinksBox.grid(column=4, row=7, sticky=W)
# Note: because backslashes are used to indicate datatypes of strings, some have to be escaped.  For example, "\b" indicates 
# a binary number, so in that case the backslash needs to be escaped as "\\b"
vunetIdBrightspaceEmailLinksBox.insert(END, 'c:\github\msc\python\grade-mover\\vunetid-email.csv')

topHatEmailIdLabel = StringVar()
ttk.Label(mainframe, textvariable=topHatEmailIdLabel).grid(column=3, row=8, sticky=(W, E))
topHatEmailIdLabel.set('Column header for TopHat email identifier')
topHatEmailIdLabelBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
topHatEmailIdLabelBox.grid(column=4, row=8, sticky=W)
topHatEmailIdLabelBox.insert(END, 'topHatEmail')

ttk.Label(mainframe, textvariable=emptyText).grid(column=3, row=9, sticky=(W, E))

brightspaceUploadFile = StringVar()
ttk.Label(mainframe, textvariable=brightspaceUploadFile).grid(column=3, row=10, sticky=(W, E))
brightspaceUploadFile.set('Brightspace upload file')
brightspaceUploadFileBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
brightspaceUploadFileBox.grid(column=4, row=10, sticky=W)
brightspaceUploadFileBox.insert(END, 'c:\github\msc\python\grade-mover\\brightspace-upload.csv')

brightspaceGradeLabel = StringVar()
ttk.Label(mainframe, textvariable=brightspaceGradeLabel).grid(column=3, row=11, sticky=(W, E))
brightspaceGradeLabel.set('Grade item label in Brightspace')
brightspaceGradeLabelBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
brightspaceGradeLabelBox.grid(column=4, row=11, sticky=W)
brightspaceGradeLabelBox.insert(END, 'Reading Quiz')

ttk.Label(mainframe, textvariable=emptyText).grid(column=3, row=12, sticky=(W, E))

startSection = StringVar()
ttk.Label(mainframe, textvariable=startSection).grid(column=3, row=13, sticky=(W, E))
startSection.set('Beginning section number')
startSectionBox = ttk.Entry(mainframe, width = 10, textvariable = StringVar())
startSectionBox.grid(column=4, row=13, sticky=W)
startSectionBox.insert(END, '1')

endSection = StringVar()
ttk.Label(mainframe, textvariable=endSection).grid(column=3, row=14, sticky=(W, E))
endSection.set('Ending section number')
endSectionBox = ttk.Entry(mainframe, width = 10, textvariable = StringVar())
endSectionBox.grid(column=4, row=14, sticky=W)
endSectionBox.insert(END, '2')

#set up action button
def moveGradesButtonClick():
	moveGrades()
gitToBaseButton = ttk.Button(mainframe, text = "Transfer grades", width = 30, command = lambda: moveGradesButtonClick() )
gitToBaseButton.grid(column=4, row=15, sticky=W)

#set up scrolling log window
ttk.Label(mainframe, textvariable=emptyText).grid(column=3, row=17, sticky=(W, E))

logText = StringVar()
ttk.Label(mainframe, textvariable=logText).grid(column=3, row=18, sticky=(W, E))
logText.set('Action log')
#scrolling text box hacked from https://www.daniweb.com/programming/software-development/code/492625/exploring-tkinter-s-scrolledtext-widget-python
edit_space = tkst.ScrolledText(master = mainframe, width  = 90, height = 25)
# the padx/pady space will form a frame
edit_space.grid(column=4, row=18, padx=8, pady=8)
edit_space.insert(END, '')

# ------------------------------------------------------------------------------------------
# Function definitions

def moveGrades():  # This is the function that is invoked when the Move Grades button is clicked
	startSec = int(startSectionBox.get()) # get the starting section number from the input box and turn it into an integer
	endSec = int(endSectionBox.get())

	# Load the data from the VUnetID/Brightspace Email mapping file into a dictionary
	vunetIdBrightspaceEmailPath = vunetIdBrightspaceEmailLinksBox.get()
	vunetIdBrightspaceEmailCsv = open(vunetIdBrightspaceEmailPath, newline='')
	vunetIdBrightspaceEmailDictionary = csv.DictReader(vunetIdBrightspaceEmailCsv)
	vunetIdBrightspaceEmailData = list(vunetIdBrightspaceEmailDictionary) # convert the dictionary to a list so it can be re-iterated
	# see https://stackoverflow.com/questions/37257774/how-to-return-to-the-beginning-of-a-dictreader for discussion
	
	# Open the CSV file that will contain the data formatted to be uploaded and consumed by Brightspace 
	brightspaceDataFile = open(brightspaceUploadFileBox.get(), 'w', newline='')
	brightspaceDataOutput = csv.writer(brightspaceDataFile)
	
	# Create the column header labels for the Brightspace upload CSV file and write them to the file
	brightspaceGradeLabelString = brightspaceGradeLabelBox.get() # get the label to be used for the grade item in the Brightspace import
	outputHeaders = (brightspaceUserIdLabel,brightspaceUsernameLabel,brightspaceGradeLabelString + " Points Grade"," End-of-Line Indicator")
	brightspaceDataOutput.writerow(outputHeaders)

	# Iterate through each section in the specified range
	for section in range(startSec,endSec+1):
		sectionString = str(section)
		writeSectionGrades(sectionString,vunetIdBrightspaceEmailData,brightspaceDataOutput)
		updateLog("Finished writing section " + sectionString + "\n\n")
	
def writeSectionGrades(sectionString,vunetIdBrightspaceEmailData,brightspaceDataOutput):  # Write the grades for a particular section
	# Load data from the source CSV file downloaded from TopHat
	topHatPath = topHatPathPrefixBox.get() + sectionString + topHatPathSuffixBox.get()
	topHatCsv = open(topHatPath, newline='')
	topHatData = csv.reader(topHatCsv)
	
	logOutput = ""
	topHatEmailId = topHatEmailIdLabelBox.get() # get the column header that was used in the VUnetID/Brightspace Email mapping file
	topHatInputGrade = topHatInputGradeLabelBox.get() # find out the label used for the grade average column in the TopHat output file
	
	gradeRowNum = 0
	for gradeRow in topHatData:
		if gradeRowNum == 0:    # the first row has headers rather than grades
			# find which column contains the identifier and which column contains the grade
			for i in range(len(gradeRow)):
				if gradeRow[i] == topHatInputEmailIdLabel:
					topHatEmailColumn = i
				if gradeRow[i] == topHatInputGrade:
					topHatGradeColumn = i
		else:
			match = False  # reset the flag that tracks whether a match was made
			for person in vunetIdBrightspaceEmailData:
				# Check each entry in the person dictionary to find a match with the TopHat email address for the current grade row
				if person[topHatEmailId] == gradeRow[topHatEmailColumn]:
					vunetId = person[userIdLabel]
					match = True  # set the flag since a match was made
			grade = gradeRow[topHatGradeColumn]
			if match == True:
				# the looked-up VUnet ID and grade are output to the CSV file
				outputLine = (vunetId,vunetId,grade,"#")
				brightspaceDataOutput.writerow(outputLine)
			else:
				logOutput = logOutput + gradeRow[topHatEmailColumn] + " not matched in VUnetID/Brightspace Email mapping file\n"
		gradeRowNum +=1
	updateLog(logOutput)

def updateLog(message):
	edit_space.insert(END, message)
	edit_space.see(END) #causes scroll up as text is added
	root.update_idletasks() # causes updated to log window, see https://stackoverflow.com/questions/6588141/update-a-tkinter-text-widget-as-its-written-rather-than-after-the-class-is-fini

def main():	
	root.mainloop()
	
if __name__=="__main__":
	main()
