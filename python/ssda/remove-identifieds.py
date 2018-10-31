# import csv #library to read/write/parse CSV files
import csv

# read in the master CSV file
path = "master-volume.csv"
masterCsvObject = open(path, newline='')
masterVolumeData = csv.reader(masterCsvObject)

# create an array of identifiers for records already associated with essss numbers
identified = []
path = "identified.csv"
idCsvObject = open(path, newline='')
identifiedData = csv.reader(idCsvObject)

rowNum = 0
for row in identifiedData:
    if rowNum != 0:
        identified.append(row[0])
    rowNum += 1

# Open the CSV file that will contain the data not yet associated with essss numbers
unassociatedFileObject = open("unassociated.csv", 'w', newline='')
unassociatedDataOutput = csv.writer(unassociatedFileObject)

# sort out rows in the master CSV file that match
columnHeaderString = "essss"

rowNum = 0
for row in masterVolumeData:
    if rowNum == 0:    # the first row has headers
        # find which column contains the essss identifier
        outputHeaders = []
        for i in range(len(row)):
            outputHeaders.append(row[i])
            if row[i] == columnHeaderString:
                essssColumn = i

        # Write the column header labels for the output CSV to the file
        unassociatedDataOutput.writerow(outputHeaders)
    else:
        # go through the identifiers and find whether they match with the row
        rowIsIdentified = False
        for id in identified:
            if id == row[essssColumn]:
                rowIsIdentified = True

        # if the row isn't identified, write it to the file
        if rowIsIdentified == False:
            rowItems = []
            for i in range(len(row)):
                rowItems.append(row[i])
            unassociatedDataOutput.writerow(rowItems)
    rowNum += 1

unassociatedFileObject.close()
masterCsvObject.close()
idCsvObject.close()
