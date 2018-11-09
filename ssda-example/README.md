# XQuery using BaseX
2018-11-08

## Sample data

The data in this example comes from the Slave Societies Digital Archive project (https://www.slavesocieties.org/), directed by Jane Landers, Vanderbilt Department of History, and is open data.

The data files are at https://github.com/baskaufs/msc/tree/master/ssda-example

To directly access one of the source XML files, go to the raw version, for example:  https://raw.githubusercontent.com/baskaufs/msc/master/ssda-example/2223MODS.xml

## Load an XML file directly into BaseX from the Internet

Show a document:
```
xquery version "3.1";

let $document := fn:doc('https://raw.githubusercontent.com/baskaufs/msc/master/ssda-example/2223MODS.xml')
return $document
```

(The prologue will be omitted in future examples for brevity.)

A more complicated query:
```
declare default element namespace  "http://www.loc.gov/mods/v3";

let $document := fn:doc('https://raw.githubusercontent.com/baskaufs/msc/master/ssda-example/2223MODS.xml')
for $name in $document/mods/name
return ( $name/role/roleTerm/text() || ': ' || $name/namePart/text() )
```

fn:doc can be used to retrieve a file on your local drive using the file: URI form:
```
let $document := fn:doc('file:///c:/github/msc/ssda-example/2223MODS.xml')
return $document
```

## Loading a CSV file directly into BaseX and turning it into XML

This example uses data from the Architectura Sinica project (https://architecturasinica.org/) directed by Tracy Miller of the Department of History of Department.  Here's the relevant CSV file

https://github.com/baskaufs/guid-o-matic/blob/master/buildings.csv

The first example opens that CSV file on your local computer:
```
let $buildingsDoc := file:read-text( 'file:///c:/github/guid-o-matic/buildings.csv')
let $buildingsXml := csv:parse($buildingsDoc, map { 'header' : true(),'separator' : "," })
return $buildingsXml
```
Notes:

- The first line loads the file as text
- The second line turns the CSV text into XML (the file has a header row and fields are separated by commas)
- The file path is idiosyncratic based on the operating system (PC vs. Mac)


The second example opens the same file through the Internet:
```
let $buildingsDoc := http:send-request(<http:request method='get' href='https://raw.githubusercontent.com/baskaufs/guid-o-matic/master/buildings.csv'/>)[2]
let $buildingsXml := csv:parse($buildingsDoc, map { 'header' : true(),'separator' : "," })
return $buildingsXml
```
Notes:

- The second line does exactly the same thing as in the previous examples
- The first line makes an explicit HTTP GET request.  The second, data element ("[2]") is selected to ignore the first, response element.

## Loading XML data from an API

In this example, we request data on Bryan Schindler (http://orcid.org/0000-0003-3127-2722) from the ORCID API.  The query as given lists his publications.

```
declare namespace search="http://www.orcid.org/ns/search";
declare namespace common="http://www.orcid.org/ns/common";
declare namespace record="http://www.orcid.org/ns/record";

(: Accept header must be specified explicitly as below.  Options are "application/json" for JSON and "application/xml" for XML. :)
let $request := <http:request href='https://orcid.org/0000-0003-3127-2722' method='get'><http:header name='Accept' value='application/xml'/></http:request>
let $responseXml := http:send-request($request)[2]
return $responseXml//common:title/text()
```
Notes:

- This is similar to the previous example, but it includes an Accept: header requesting XML (content negotiation).  Without that, HTML (a web page) would be returned.
- Try changing the Accept: header to JSON (application/json).  Although the response is in JSON, BaseX converts it to XML using a pattern similar to the CSV conversion.

## Loading XML data into BaseX's database

Return to the SSDA example data https://github.com/baskaufs/msc/tree/master/ssda-example and download the zip file (click on the name, then the download button).  Unzip the file to somewhere you can find it.

In BaseX, go to the Database menu, and click new.  Browse to the folder where you unzipped the files.  If necessary, change the name of the database to something reasonable.  Leave all of the defaults as they are and click OK.

Query to return data from all five files:

```
let $data := fn:collection('ssda-example')
return $data
```

Query to list the titles of the five digitized books represented by the five records:
```
xquery version "3.1";
declare default element namespace  "http://www.loc.gov/mods/v3";

let $data := fn:collection('ssda-example')
return $data//titleInfo/title/text()
```
