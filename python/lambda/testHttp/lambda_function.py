import requests

def lambda_handler(event, context):
    r = requests.get("http://bioimages.vanderbilt.edu/baskauf/24319.rdf")
    return r.text
