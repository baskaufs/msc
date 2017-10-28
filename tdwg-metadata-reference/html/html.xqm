xquery version "3.1";

module namespace html = 'http://rs.tdwg.com/html';

(:--------------------------------------------------------------------------------------------------:)

(: This is the test template web page for the /home URI pattern :)
declare function html:generate-list($db)
{
let $constants := fn:collection($db)//constants/record
let $baseIriColumn := $constants//baseIriColumn/text()

let $metadata := fn:collection($db)/metadata/record
  
return 
<html>
  <head>
    <meta charset="utf-8"/>
    <title>Test generated web page</title>
      <link href="https://raw.githubusercontent.com/baskaufs/tdwg-standards/master/html/config/default.css" rel="stylesheet" type="text/css"/>

  </head>
  <body>
     <table cellspacing="0" class="border">
       <tbody>
       <!-- Begin Terms Table -->
       {
       for $record in $metadata
       return (
         <tr><th colspan="2"><a name="{$record/term_localName/text()}">Term Name: {$record/label/text()}</a></th></tr>,
         <tr><td>Identifier:</td><td>{$record/term_isDefinedBy/text()||$record/term_localName/text()}</td></tr>,
         <tr><td>Class:</td><td>{$record/dwcattributes_organizedInClass/text()}</td></tr>,
         <tr><td>Definition:</td><td>{$record/rdfs_comment/text()}</td></tr>,
         <tr><td>Comment:</td><td>{$record/dcterms_description/text()||" For discussion see "}<a href="{'http://terms.tdwg.org/wiki/dwc:'||$record/term_localName/text()}">{'http://terms.tdwg.org/wiki/dwc:'||$record/term_localName/text()}</a></td></tr>,
         <tr><td>Details:</td><td><a href="{$record/version/text()}">{$record/term_localName/text()}</a></td></tr>
         )
       }
       </tbody>
     </table>
  </body>
</html>
};

(: Generates web page for term lists :)
declare function html:term-list($lookup-string)
{
let $constants := fn:collection("term-lists")//constants/record
let $baseIriColumn := $constants//baseIriColumn/text()

let $metadata := fn:collection("term-lists")/metadata/record
  
return 
<html>
  <head>
    <meta charset="utf-8"/>
    <title>term list web page</title>
  </head>
  <body>
    <p>{$lookup-string}</p>
  </body>
</html>
};

(: Generates web page for term lists versions :)
declare function html:term-lists-versions($lookup-string)
{
let $constants := fn:collection("term-lists-versions")//constants/record
let $baseIriColumn := $constants//baseIriColumn/text()

let $metadata := fn:collection("term-lists-versions")/metadata/record
  
return 
<html>
  <head>
    <meta charset="utf-8"/>
    <title>term list versions web page</title>
  </head>
  <body>
    <p>{$lookup-string}</p>
  </body>
</html>
};

(: Generates web page for "iri" namespace terms :)
declare function html:iri($lookup-string)
{
let $constants := fn:collection("iri")//constants/record
let $baseIriColumn := $constants//baseIriColumn/text()

let $metadata := fn:collection("iri")/metadata/record
  
return 
<html>
  <head>
    <meta charset="utf-8"/>
    <title>iri versions web page</title>
  </head>
  <body>{
    for $record in $metadata
    where $lookup-string = $record/term_localName/text()
    return
      <p>{"URI: "||$record/term_isDefinedBy/text()||$record/list/text()}<br/>{"Label: "||$record/label/text()}<br/>{"Definition: "||$record/rdfs_comment/text()}</p>
   }</body>
</html>
};
