import requests
import shutil

# Write data to file
url = "https://farm9.staticflickr.com/8154/7660206660_92d05c90e3_o.jpg"
filename = "7660206660_92d05c90e3_o.jpg"
response = requests.get(url)
status = response.status_code
print(status)
with open (filename,'wb') as out_file:
    for chunk in response.iter_content(chunk_size=128):
        out_file.write(chunk)




