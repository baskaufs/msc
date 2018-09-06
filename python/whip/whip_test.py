from pywhip import whip_csv
import yaml

specs = """
    dsw_identified:
        stringformat: url
    dwc_dateIdentified:
        dateformat: ['%Y-%m-%d', '%Y-%m', '%Y']
        mindate: 2000-01-01
        maxdate: 2018-12-31
    identifiedBy:
        allowed: [phoebusp, baskauf]
    """
   
specifications = yaml.load(specs)

example = whip_csv("determinations.csv", specifications, delimiter='|')

with open("report_example.html", "w") as index_page:
    index_page.write(example.get_report('html'))