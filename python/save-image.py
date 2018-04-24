import requests
import shutil

# Write data to file
url = "https://farm9.staticflickr.com/8154/7660206660_92d05c90e3_o.jpg"
filename = "7660206660_92d05c90e3_o.jpg"
response = requests.get(url, stream=True)
#status = requests.status_code
with open (filename,'wb') as out_file:
	shutil.copyfileobj(response.raw, out_file)
del response



