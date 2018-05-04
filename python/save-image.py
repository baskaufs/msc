import requests
import shutil
import csv #library to read/write/parse CSV files

url = "https://farm9.staticflickr.com/8154/7660206660_92d05c90e3_o.jpg"
path = "c:\\test\\chapman-output\\"
infile = "c:\\test\\flickr\\urls.txt"



# Open the CSV file that will store the HTTP response codes for each Get 
statusFile = open(path + "status.csv", 'w', newline='')
statusOutput = csv.writer(statusFile)

# open the text file containing the URLs for the highres images
topHatCsv = open(infile, newline='')
topHatData = csv.reader(topHatCsv)
for gradeRow in topHatData:
	url = gradeRow[0].strip()
	filename = url.split("/")[4]
	
	# Write data to file
	response = requests.get(url)
	status = response.status_code
	outputLine = (status,url)
	statusOutput.writerow(outputLine)
	
	with open (path + filename,'wb') as out_file:
		for chunk in response.iter_content(chunk_size=128):
			out_file.write(chunk)




