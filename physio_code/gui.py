
# ------------
# import modules
# ------------

from tkinter import *
import tkinter.scrolledtext as tkst
import datetime
import time
import pandas as pd

# ------------
# Functions
# ------------

def collect_data_button_click():
    """Handle the click of the "Send Query" button"""
    file_path = filename_text_box.get('1.0','end') # Gets all text from first character to last

    # Get rid of any leading and trailing whitespace.
    file_path = file_path.strip()

    # Create a DataFrame to hold the collected data
    data = pd.DataFrame(columns=['Time', 'GSR', 'Heart Rate'])

    # Collect data
    fake_datapoint_dict = {'Time': [datetime.datetime.now()], 'GSR': 1, 'Heart Rate': 2}
    updateLog(str(fake_datapoint_dict))

    # Add the data to the DataFrame
    data = data.append(pd.DataFrame(fake_datapoint_dict), ignore_index=True)

    # Save the file
    data.to_csv(file_path, index=False)

def updateLog(message):
	edit_space.insert(END, message + '\n')
	edit_space.see(END) #causes scroll up as text is added
	root.update_idletasks() # causes update to log window, see https://stackoverflow.com/questions/6588141/update-a-tkinter-text-widget-as-its-written-rather-than-after-the-class-is-fini

# ------------
# Set up GUI
# ------------

root = Tk()

# this sets up the characteristics of the window
root.title('GSR/Heart rate monitor')

# Create a frame object for the main window
mainframe = Frame(root)
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

# Create a label object for instructions
instruction_text = StringVar()
Label(mainframe, textvariable=instruction_text).grid(column=1, row=3, sticky=(W, E))
instruction_text.set('Enter file name below, then click the Run button')

# Create a text box object for the file name, 30 characters wide and 1 line high
filename_text_box = Text(mainframe, width=30, height=1)
filename_text_box.grid(column=1, row=4, sticky=(W, E))

# Insert the generic query text
filename_text_box.insert(END, 'path/filename.csv')


# Create a button object for sending the query
send_query_button = Button(mainframe, text = 'Run', width = 30, command = lambda: collect_data_button_click() )
send_query_button.grid(column=1, row=6, sticky=W)

# Create a scrolling text box to display the log
edit_space = tkst.ScrolledText(master = mainframe, width  = 100, height = 25)
# the padx/pady space will form a frame
edit_space.grid(column=1, row=2, padx=8, pady=8)
edit_space.insert(END, '')


def main():	
    root.mainloop()
	
if __name__=='__main__':
	main()