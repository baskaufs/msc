import requests

r = requests.get("http://bioimages.vanderbilt.edu/baskauf/24319.rdf")
print(r.text)
