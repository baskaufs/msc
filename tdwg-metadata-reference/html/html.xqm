xquery version "3.1";

module namespace html = 'http://rs.tdwg.com/html';

(:--------------------------------------------------------------------------------------------------:)
(: utility functions from http://www.xqueryfunctions.com/xq/ :)

declare function html:substring-before-last
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string {

   if (matches($arg, html:escape-for-regex($delim)))
   then replace($arg,
            concat('^(.*)', html:escape-for-regex($delim),'.*'),
            '$1')
   else ''
 } ;
 
 declare function html:escape-for-regex
  ( $arg as xs:string? )  as xs:string {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;

(:--------------------------------------------------------------------------------------------------:)
(: 1st level functions :)

(: Generates web page for a term list; ; usually following the pattern http://rs.tdwg.org/{vocab}/{list}/ :)
declare function html:generate-term-list-html($termListIri as xs:string) as element()
{
let $listMetadata := html:load-list-metadata-record($termListIri,"term-lists")
let $ns := html:find-list-ns-abbreviation($termListIri)
let $std := html:find-standard-for-list($termListIri)
let $version := html:find-version-for-list($termListIri)
return
<html>
  <head>
    <meta charset="utf-8"/>
    <title>{$listMetadata/label/text()}</title>
  </head>
  <body>{
    html:generate-list-metadata-html($listMetadata,$std,$version),
    html:generate-list-html(html:find-list-dbname($termListIri),$ns)
   }</body>
</html>
};

(: Generates web page for term lists versions; usually following the pattern http://rs.tdwg.org/{vocab}/version/{term-list}/{iso-date} :)
declare function html:generate-term-list-version-html($termListVersionIri as xs:string) as element()
{
let $listMetadata := html:load-list-metadata-record($termListVersionIri,"term-lists-versions")
let $versionRoot := html:substring-before-last($termListVersionIri,"/") (: find the part of the version before the ISO 8601 date :)
let $termListIri := replace($versionRoot,'version/','')||"/"
let $ns := html:find-list-ns-abbreviation($termListIri)
let $std := html:find-standard-for-list($termListIri)
let $members := html:generate-list-version-members($termListVersionIri)
return
<html>
  <head>
    <meta charset="utf-8"/>
    <title>{$listMetadata/label/text()}</title>
  </head>
  <body>{
    html:generate-list-versions-metadata-html($listMetadata,$std,$termListIri),
    html:generate-list-versions-html(html:find-list-version-dbname($termListIri),$ns,$members)
   }</body>
</html>
};

(:--------------------------------------------------------------------------------------------------:)
(: 2nd level functions :)

(: go through the term list records and pull the metadata for the particular list. There should be exactly one record element returned :)
declare function html:load-list-metadata-record($list-iri as xs:string,$db as xs:string) as element()
{
let $config := fn:collection($db)/constants/record (: get the term lists configuration data :)
let $key := $config/baseIriColumn/text() (: determine which column in the source table contains the primary key for the record :)
let $metadata := fn:collection($db)/metadata/record

for $record in $metadata
where $record/*[local-name()=$key]/text()=$list-iri (: the primary key of the record row must match the requested list :)
return $record
};

(: Generate a sequence of the members of a particular term list version :)
declare function html:generate-list-version-members($termListVersion as xs:string) as xs:string+
{
  let $listsMembers := fn:collection("term-lists-versions")/linked-metadata/file/metadata/record
  for $member in $listsMembers
  where $member/termListVersion/text() = $termListVersion
  order by $member/termVersion/text()
  return $member/termVersion/text()
};

(: Looks up the name of the database that contains the metadata for the terms in a term list :)
declare function html:find-list-dbname($list_localName as xs:string) as xs:string
{
switch ($list_localName) 
   case "http://rs.tdwg.org/dwc/dwctype/" return "dwctype"
   case "http://rs.tdwg.org/dwc/curatorial/" return "curatorial"
   case "http://rs.tdwg.org/dwc/dwcore/" return "dwcore"
   case "http://rs.tdwg.org/dwc/geospatial/" return "geospatial"
   case "http://rs.tdwg.org/dwc/terms/" return "terms"
   case "http://rs.tdwg.org/dwc/terms/attributes/" return "utility"
   case "http://rs.tdwg.org/dwc/iri/" return "iri"
   case "http://rs.tdwg.org/ac/terms/" return "audubon"
   case "http://rs.tdwg.org/dwc/dc/" return "dc-for-dwc"
   case "http://rs.tdwg.org/dwc/dcterms/" return "dcterms-for-dwc"
   case "http://rs.tdwg.org/ac/borrowed/" return "ac-borrowed"
   case "http://rs.tdwg.org/decisions/" return "decisions"
   default return "database name not found"
};

(: Looks up the name of the database that contains the metadata for the terms in a term list :)
declare function html:find-list-version-dbname($list_localName as xs:string) as xs:string
{
switch ($list_localName) 
   case "http://rs.tdwg.org/dwc/dwctype/" return "dwctype-versions"
   case "http://rs.tdwg.org/dwc/curatorial/" return "curatorial-versions"
   case "http://rs.tdwg.org/dwc/dwcore/" return "dwcore-versions"
   case "http://rs.tdwg.org/dwc/geospatial/" return "geospatial-versions"
   case "http://rs.tdwg.org/dwc/terms/" return "terms-versions"
   case "http://rs.tdwg.org/dwc/terms/attributes/" return "utility-versions"
   case "http://rs.tdwg.org/dwc/iri/" return "iri-versions"
   case "http://rs.tdwg.org/ac/terms/" return "audubon-versions"
   case "http://rs.tdwg.org/dwc/dc/" return "dc-for-dwc-versions"
   case "http://rs.tdwg.org/dwc/dcterms/" return "dcterms-for-dwc-versions"
   default return "database name not found"
};

(: Looks up the abbreviation for the namespace associated with terms in a term list :)
declare function html:find-list-ns-abbreviation($list_localName as xs:string) as xs:string
{
switch ($list_localName) 
   case "http://rs.tdwg.org/dwc/dwctype/" return "dwctype"
   case "http://rs.tdwg.org/dwc/curatorial/" return "dwccuratorial"
   case "http://rs.tdwg.org/dwc/dwcore/" return "dwcore"
   case "http://rs.tdwg.org/dwc/geospatial/" return "dwcgeospatial"
   case "http://rs.tdwg.org/dwc/terms/" return "dwc"
   case "http://rs.tdwg.org/dwc/terms/attributes/" return "tdwgutility"
   case "http://rs.tdwg.org/dwc/iri/" return "dwciri"
   case "http://rs.tdwg.org/ac/terms/" return "ac"
   case "http://rs.tdwg.org/dwc/dc/" return "dc"
   case "http://rs.tdwg.org/dwc/dcterms/" return "dcterms"
   case "http://rs.tdwg.org/ac/borrowed/" return ""
   case "http://rs.tdwg.org/decisions/" return "tdwgdecisions"
   default return "namespace not found"
};

(: Looks up the abbreviation for the namespace associated with terms in a term list :)
declare function html:find-standard-for-list($list_localName as xs:string) as xs:string
{
switch ($list_localName) 
   case "http://rs.tdwg.org/dwc/dwctype/" return "http://www.tdwg.org/standards/450"
   case "http://rs.tdwg.org/dwc/curatorial/" return ""
   case "http://rs.tdwg.org/dwc/dwcore/" return ""
   case "http://rs.tdwg.org/dwc/geospatial/" return ""
   case "http://rs.tdwg.org/dwc/terms/" return "http://www.tdwg.org/standards/450"
   case "http://rs.tdwg.org/dwc/terms/attributes/" return ""
   case "http://rs.tdwg.org/dwc/iri/" return "http://www.tdwg.org/standards/450"
   case "http://rs.tdwg.org/ac/terms/" return "http://www.tdwg.org/standards/638"
   case "http://rs.tdwg.org/dwc/dc/" return "http://www.tdwg.org/standards/450"
   case "http://rs.tdwg.org/dwc/dcterms/" return "http://www.tdwg.org/standards/450"
   case "http://rs.tdwg.org/ac/borrowed/" return "http://www.tdwg.org/standards/638"
   case "http://rs.tdwg.org/decisions/" return ""
   default return "standard not found"
};

(: Looks up the abbreviation for the namespace associated with terms in a term list :)
declare function html:find-version-for-list($list_localName as xs:string) as xs:string
{
switch ($list_localName) 
   case "http://rs.tdwg.org/dwc/dwctype/" return "http://rs.tdwg.org/dwc/version/dwctype/"
   case "http://rs.tdwg.org/dwc/curatorial/" return "http://rs.tdwg.org/dwc/version/curatorial/"
   case "http://rs.tdwg.org/dwc/dwcore/" return "http://rs.tdwg.org/dwc/version/dwcore/"
   case "http://rs.tdwg.org/dwc/geospatial/" return "http://rs.tdwg.org/dwc/version/geospatial/"
   case "http://rs.tdwg.org/dwc/terms/" return "http://rs.tdwg.org/dwc/version/terms/"
   case "http://rs.tdwg.org/dwc/terms/attributes/" return "http://rs.tdwg.org/dwc/terms/version/attributes/"
   case "http://rs.tdwg.org/dwc/iri/" return "http://rs.tdwg.org/dwc/version/iri/"
   case "http://rs.tdwg.org/ac/terms/" return "http://rs.tdwg.org/ac/version/terms/"
   case "http://rs.tdwg.org/dwc/dc/" return "http://rs.tdwg.org/dwc/version/dc/"
   case "http://rs.tdwg.org/dwc/dcterms/" return "http://rs.tdwg.org/dwc/version/dcterms/"
   case "http://rs.tdwg.org/ac/borrowed/" return "http://rs.tdwg.org/ac/version/borrowed/"
   case "http://rs.tdwg.org/decisions/" return "http://rs.tdwg.org/version/decisions/"
   default return "database name not found"
};

(: Generates metadata for a particular list :)
declare function html:generate-list-metadata-html($record as element(),$std as xs:string,$version as xs:string) as element()
{
let $thisVersion := $version||$record/list_modified/text()
return  
<div>{
  <strong>Title: </strong>,<span>{$record/label/text()}</span>,<br/>,
  <strong>Date version issued: </strong>,<span>{$record/list_modified/text()}</span>,<br/>,
  <strong>Date created: </strong>,<span>{$record/list_created/text()}</span>,<br/>,

  if ($std != "")
  then (
    <strong>Part of TDWG Standard: </strong>,<a href='{$std}'>{$std}</a>,<br/>
    )
  else (
    <span>Not part of any TDWG Standard</span>,<br/>
    ),
  
  <strong>This version: </strong>,<a href='{$thisVersion}'>{$thisVersion}</a>,<br/>,
  <strong>Latest version: </strong>,<a href='{$record/list/text()}'>{$record/list/text()}</a>,<br/>,
  <strong>Abstract: </strong>,<span>{$record/description/text()}</span>,<br/>,
  
  if ($record/vann_preferredNamespacePrefix/text() != "")
  then (
    <strong>Namespace IRI: </strong>,<span>{$record/vann_preferredNamespaceUri/text()}</span>,<br/>,
    <strong>Preferred namespace abbreviation: </strong>,<span>{$record/vann_preferredNamespacePrefix/text()||":"}</span>,<br/>
    )
  else (),
  
  if ($record/list_deprecated/text() = "true")
  then (
    <strong>Status note: </strong>,<span>This term list has been deprecated and is no longer recommended for use.</span>,<br/>
    )
  else (),
  <br/>
  
}</div>
};

(: Generate the HTML table of metadata about the terms in the list:)
declare function html:generate-list-html($db as xs:string,$ns as xs:string) as element()
{
let $metadata := fn:collection($db)/metadata/record
  
return 
     <div>
       {
       for $record in $metadata
       let $version := $record/term_isDefinedBy/text()||"version/"||$record/term_localName/text()||"-"||$record/term_modified/text()
       order by $record/term_localName/text()
       return (
         <table>{
         <tr><td><a name="{$record/term_localName/text()}"><strong>Term Name:</strong></a></td><td>{$ns||":"||$record/term_localName/text()}</td></tr>,
         <tr><td><strong>Label:</strong></td><td>{$record/label/text()}</td></tr>,
         <tr><td><strong>Term IRI:</strong></td><td>{$record/term_isDefinedBy/text()||$record/term_localName/text()}</td></tr>,

         (: terms not defined by TDWG may have different version patterns, or may not have versions :)
         if (contains($record/term_isDefinedBy/text(),"rs.tdwg.org"))
         then (
         <tr><td><strong>Term version IRI:</strong></td><td><a href='{$version}'>{$version}</a></td></tr>
         )
         else (),

         <tr><td><strong>Modified:</strong></td><td>{$record/term_modified/text()}</td></tr>,
         <tr><td><strong>Definition:</strong></td><td>{$record/rdfs_comment/text()}</td></tr>,
         <tr><td><strong>Type:</strong></td><td>{substring-after($record/rdf_type/text(),"#")}</td></tr>,
         
         if ($record/term_deprecated/text() != "")
         then (
         <tr><td><strong>Note:</strong></td><td>This term is no longer recommended for use.</td></tr>
         )
         else ()

         }</table>,<br/>
         )
       }
     </div>
};

(: Generates metadata for a list version :)
declare function html:generate-list-versions-metadata-html($record as element(),$std as xs:string,$termListIri as xs:string) as element()
{

<div>{
  <strong>Title: </strong>,<span>{$record/label/text()}</span>,<br/>,
  <strong>Issued: </strong>,<span>{$record/version_modified/text()}</span>,<br/>,

  if ($std != "")
  then (
    <strong>Part of TDWG Standard: </strong>,<a href='{$std}'>{$std}</a>,<br/>
    )
  else (
    <span>Not part of any TDWG Standard</span>,<br/>
    ),
  
  <strong>This version: </strong>,<a href='{$record/version/text()}'>{$record/version/text()}</a>,<br/>,
  <strong>Version of: </strong>,<a href='{$termListIri}'>{$termListIri}</a>,<br/>,
  <strong>Abstract: </strong>,<span>This version shows the state of the term list on the date that it was issued.</span>,<br/>,
  
  if ($record/vann_preferredNamespacePrefix/text() != "")
  then (
    <strong>Namespace IRI: </strong>,<span>{$record/vann_preferredNamespaceUri/text()}</span>,<br/>,
    <strong>Preferred namespace abbreviation: </strong>,<span>{$record/vann_preferredNamespacePrefix/text()||":"}</span>,<br/>
    )
  else (),
  
  if ($record/list_deprecated/text() = "true")
  then (
    <strong>Status note: </strong>,<span>This term list has been deprecated and is no longer recommended for use.</span>,<br/>
    )
  else (),
  <br/>
  
}</div>
};

(: Generate the HTML table of metadata about the terms in the list:)
declare function html:generate-list-versions-html($db as xs:string,$ns as xs:string,$members as xs:string+) as element()
{
let $metadata := fn:collection($db)/metadata/record
let $replacements := fn:collection($db)/linked-metadata/file/metadata/record
return 
     <div>
       {
       for $record in $metadata, $member in $members
       where $record/version/text()=$member
       order by $record/term_localName/text()
       let $versionRoot := substring($record/version/text(),1,
fn:string-length($record/version/text())-11) (: find the part of the version before the ISO 8601 date :)
       let $versionOf := replace($versionRoot,'version/','')
       return (
         <table>{
         <tr><td><a name="{$record/term_localName/text()}"><strong>Term Name:</strong></a></td><td>{$ns||":"||$record/term_localName/text()}</td></tr>,
         <tr><td><strong>Label:</strong></td><td>{$record/label/text()}</td></tr>,
         <tr><td><strong>Term version IRI:</strong></td><td>{$record/version/text()}</td></tr>,
         <tr><td><strong>Version of:</strong></td><td><a href='{$versionOf}'>{$versionOf}</a></td></tr>,
         <tr><td><strong>Issued:</strong></td><td>{$record/version_issued/text()}</td></tr>,
         <tr><td><strong>Definition:</strong></td><td>{$record/rdfs_comment/text()}</td></tr>,
         <tr><td><strong>Type:</strong></td><td>{substring-after($record/rdf_type/text(),"#")}</td></tr>,
         <tr><td><strong>Status:</strong></td><td>{$record/version_status/text()}</td></tr>,

         if ($record/replaces_version/text() != "")
         then (
           <tr><td><strong>Replaces:</strong></td><td><a href='{$record/replaces_version/text()}'>{$record/replaces_version/text()}</a></td></tr>
           )
         else (),
         if ($record/replaces1_version/text() != "")
         then (
           <tr><td><strong>Replaces:</strong></td><td><a href='{$record/replaces1_version/text()}'>{$record/replaces1_version/text()}</a></td></tr>
           )
         else (),
         if ($record/replaces2_version/text() != "")
         then (
           <tr><td><strong>Replaces:</strong></td><td><a href='{$record/replaces2_version/text()}'>{$record/replaces2_version/text()}</a></td></tr>
           )
         else (),

         for $replacement in $replacements
         where $replacement/replaced_version_localName/text() = $record/versionLocalName/text()
         return <tr><td><strong>Is replaced by:</strong></td><td><a href='{$replacement/replacing_version/text()}'>{$replacement/replacing_version/text()}</a></td></tr>

         }</table>,<br/>
         )
       }
     </div>
};

(:--------------------------------------------------------------------------------------------------:)
(: defunct test functions :)

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

declare function html:term-lists-versions($lookup-string as xs:string) as element()
{
};
