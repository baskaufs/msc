# ------------
# import modules
# ------------

from tkinter import *
import tkinter.scrolledtext as tkst
import datetime
import time
import pandas as pd
import math
import sys
import RPi.GPIO as GPIO
from grove.adc import ADC
import smbus
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

# ------------
# Global Variables
# ------------

retry_sleep = 0.1
collection_time_interval = 1

# ------------
# Functions
# ------------

# Prep for Heart Rate, take a reading with hr_value
rev = GPIO.RPI_REVISION
if rev == 2 or rev == 3:
    bus = smbus.SMBus(1)
else:
    bus = smbus.SMBus(0)

class grove_fingerclip_heart_sensor:
	address = 0x50

	def pulse_read(self):
		#print(bus.read_byte(0x50))
		return bus.read_i2c_block_data(self.address, 1,1)

pulse= grove_fingerclip_heart_sensor()

def hr_value(interval_start_time):
    # Continue trying to take a reading unless it's past the interval length.
    while datetime.datetime.now().total_seconds() - interval_start_time.total_seconds() < collection_time_interval:
        try:
            hr_value = pulse.pulse_read()
        except:
            retry += 1
            # If the reading fails beyond the interval length, the return value will be 'Failed'.
            # Otherwise, the hr_value will get replaced by a successful reading. 
            hr_value = 'Failed'
            time.sleep(retry_sleep)
    return hr_value

# GSR Setup
class GroveGSRSensor:

    def __init__(self, channel):
        self.channel = channel
        self.adc = ADC()

    @property
    def GSR(self):
        value = self.adc.read(self.channel)
        return value

Grove = GroveGSRSensor

def gsr_value(interval_start_time):
    sensor = GroveGSRSensor(int(0))
    # Continue trying to take a reading unless it's past the interval length.
    while datetime.datetime.now().total_seconds() - interval_start_time.total_seconds() < collection_time_interval:
        try:           
            #print('GSR value: {0}'.format(sensor.GSR))
            gsr_value = int(sensor.GSR)
        except:
            retry += 1
            # If the reading fails beyond the interval length, the return value will be 'Failed'.
            # Otherwise, the hr_value will get replaced by a successful reading. 
            gsr_value = 'Failed'
            time.sleep(retry_sleep)
    return gsr_value

def collect_data_button_click(): # Run button
    
    """Handle the click of the "Send Query" button"""
    
    subj = participant_text_box.get('1.0','end'); subj = subj.strip()
    session = session_text_box.get('1.0','end'); session = session.strip()
    file_path = ('/home/ebrl-pi/EM_Data/{}_v{}.csv'.format(subj,session))
    
    current_time = datetime.datetime.now()
    

    # Get rid of any leading and trailing whitespace.
    file_path = file_path.strip()
    # Create a DataFrame to hold the collected data
    data = pd.DataFrame(columns=['Time','Subject','Session','Elapsed Time', 'GSR', 'Heart Rate'])
    for i in range(30):
        updateLog('Collecting calibration heart rates for 30 seconds...' + str(i))
        # Do we need one for GSR too? GSR standard? 
        nothing = hr_value()
        time.sleep(1)
        
    # Collect data
    while True: 
    #for i in range(10):
        # Time
        elapsed_time = (datetime.datetime.now() - current_time).total_seconds() * 1000
        elapsed_time_ms = int(round(elapsed_time, 0))
        
        interval_start_time = datetime.datetime.now() # Start time for the measurement interval
        datapoint_dict = {'Time': [datetime.datetime.now()], 'GSR': gsr_value(interval_start_time), 'Heart Rate': hr_value(interval_start_time), 'Elapsed Time': elapsed_time_ms,
                              'Subject': subj, 'Session': session}
        updateLog(str(datapoint_dict))
        
        # Add the data to the DataFrame
        data = pd.concat([data, pd.DataFrame(datapoint_dict)], ignore_index=True)
        
            # Collect data
        #return data
        # Save the file
        data.to_csv(file_path, index=False)

        # Sleep for however much time there is left in the measurement interval
        time_remaining_in_interval = collection_time_interval - (datetime.datetime.now() - interval_start_time).total_seconds()
        if time_remaining_in_interval > 0:
            time.sleep(time_remaining_in_interval)

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
instruction_text.set('Enter the Participant ID and Session, then click the Run button')

# Create a text box object for the file name, 30 characters wide and 1 line high
participant_text_box = Text(mainframe, width=20, height=1)
participant_text_box.grid(column=1, row=4, sticky=(W))

# Insert the generic query text
participant_text_box.insert(END, 'NG1000')

# Create a text box for Session
session_text_box = Text(mainframe, width=10, height=1)
session_text_box.grid(column=1, row=4)
session_text_box.insert(END, '1')

# Create a button object for sending the query
send_query_button = Button(mainframe, text = 'Run', width = 30, command = lambda: collect_data_button_click() )
send_query_button.grid(column=1, row=6, sticky=W)

# Stop button? 
stop_button = Button(mainframe, text= "Stop", width= 30, command= root.quit())
stop_button.grid(column=1,row=6,sticky=E)

# Create a scrolling text box to display the log
edit_space = tkst.ScrolledText(master = mainframe, width  = 100, height = 25)
# the padx/pady space will form a frame
edit_space.grid(column=1, row=2, padx=8, pady=8)
edit_space.insert(END, '')


def main():	
    root.mainloop()
	
if __name__=='__main__':
	main()