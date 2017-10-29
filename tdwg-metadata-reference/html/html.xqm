xquery version "3.1";

module namespace html = 'http://rs.tdwg.com/html';

(: lookup functions - need to change the hard-coding when term lists are added or modified :)

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

(: Looks up the name of the database that contains the metadata for the terms in a term version list :)
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

(: Looks up the standard that a term list is associated with :)
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

(: Looks up the term list version namespace that corresponds to a term list :)
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

(:--------------------------------------------------------------------------------------------------:)
(: utility functions :)

(: from http://www.xqueryfunctions.com/xq/ :)
declare function html:substring-before-last
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string {

   if (matches($arg, html:escape-for-regex($delim)))
   then replace($arg,
            concat('^(.*)', html:escape-for-regex($delim),'.*'),
            '$1')
   else ''
 } ;
 
 (: from http://www.xqueryfunctions.com/xq/ :)
 declare function html:escape-for-regex
  ( $arg as xs:string? )  as xs:string {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;

(: go through the term list or list versions records and pull the metadata for the particular list. There should be exactly one record element returned :)
declare function html:load-metadata-record($list-iri as xs:string,$db as xs:string) as element()
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

(: Find the standard of which a vocabulary is part :)
declare function html:find-standard($vocabulary as xs:string) as xs:string
{
  let $parts := fn:collection("standards")/linked-metadata/file/metadata/record
  for $part in $parts
  where $part/part/text() = $vocabulary
  return $part/standard/text()
};

(: Generate a sequence of the term lists that are part of a particular vocabulary :)
declare function html:generate-vocabulary-term-list-members($vocabulary as xs:string) as xs:string+
{
  let $termLists := fn:collection("vocabularies")/linked-metadata/file/metadata/record
  for $termList in $termLists
  where $termList/vocabulary/text() = $vocabulary
  order by $termList/termList/text()
  return $termList/termList/text()
};

(: go through the term list or term list versions records ($db) and pull the metadata for all lists that are part of a particular vocabulary. :)
declare function html:load-list-records($termLists as xs:string+,$db as xs:string) as element()*
{
let $config := fn:collection($db)/constants/record (: get the term/term versions lists configuration data :)
let $key := $config/baseIriColumn/text() (: determine which column in the source table contains the primary key for the record :)
let $metadata := fn:collection($db)/metadata/record

for $record in $metadata,$termList in $termLists
where $record/*[local-name()=$key]/text()=$termList (: the primary key of the record row must match a list in the vocabulary :)

return $record

};

(:--------------------------------------------------------------------------------------------------:)
(: Generate vocabulary web page ////////////////////////////////////////////////////////////////////:)
(:--------------------------------------------------------------------------------------------------:)

(: 1st level function :)

(: Generates web page for a vocabulary; ; usually following the pattern http://rs.tdwg.org/{vocab}/ :)
declare function html:generate-vocabulary-html($vocabularyIri as xs:string) as element()
{
let $vocabularyMetadata := html:load-metadata-record($vocabularyIri,"vocabularies")

return
<html>
  <head>
    <meta charset="utf-8"/>
    <title>{$vocabularyMetadata/label/text()}</title>
  </head>
  <body>{
    html:generate-vocabulary-metadata-html($vocabularyMetadata),
    html:generate-vocabulary-toc-etc-html($vocabularyIri),
    html:generate-vocabulary-html($vocabularyMetadata,$vocabularyIri)
   }</body>
</html>
};

(:--------------------------------------------------------------------------------------------------:)
(: 2nd level functions :)

(: Generates HTML metadata for a particular vocabulary and returns them as a div element :)
declare function html:generate-vocabulary-metadata-html($record as element()) as element()
{
let $thisVersion := $record/vocabulary/text()||$record/vocabulary_modified/text()
let $std := html:find-standard($record/vocabulary/text())
return  
<div>{
  <strong>Title: </strong>,<span>{$record/label/text()}</span>,<br/>,
  <strong>Date version issued: </strong>,<span>{$record/vocabulary_modified/text()}</span>,<br/>,
  <strong>Date created: </strong>,<span>{$record/vocabulary_created/text()}</span>,<br/>,

  if ($std != "")
  then (
    <strong>Part of TDWG Standard: </strong>,<a href='{$std}'>{$std}</a>,<br/>
    )
  else (
    <span>Not part of any TDWG Standard</span>,<br/>
    ),
  
  <strong>This version: </strong>,<a href='{$thisVersion}'>{$thisVersion}</a>,<br/>,
  <strong>Latest version: </strong>,<a href='{$record/vocabulary/text()}'>{$record/vocabulary/text()}</a>,<br/>,
  <strong>Abstract: </strong>,<span>{$record/description/text()}</span>,<br/>,
  <strong>Creator: </strong>,<span>{$record/dc_creator/text()}</span>,<br/>,
  
  if ($record/list_deprecated/text() = "true")
  then (
    <strong>Status note: </strong>,<span>This vocabulary has been deprecated and is no longer recommended for use.</span>,<br/>
    )
  else (),
  <br/>
  
}</div>
};

(: Generates the HTML for the middle section of the vocabulary page and returns it as a div elelment :)
declare function html:generate-vocabulary-toc-etc-html($vocabularyIri as xs:string) as element()
{
<div>
  <h1>Table of Contents</h1>
  <ul style="list-style: none;">
    <li><a href="#1">1 Introduction</a></li>
    <li><a href="#2">2 Vocabulary versions</a></li>
    <li><a href="#3">3 Vocabulary distributions</a></li>
    <li><a href="#4">4 Term lists that are part of this vocabulary</a></li>
  </ul>
  <h1><a id="1">1 Introduction</a></h1>
  <p>This document provides access to the parts and history of this vocabulary.  A TDWG vocabulary is composed of term lists that have been minted by TDWG as part of this vocabulary, or that may be composed of terms borrowed from other vocabularies within or outisde of TDWG.  The vocabulary changes over time as these lists change, or as new term lists are added to the vocabulary.  These changes are documented by versions of the vocabulary, which are &quot;snapshots&quot; of the vocabulary at the time that the version was issued.</p>
  <p>For more information about the structure and version model of TDWG vocabularies, see the <a href="http://www.tdwg.org/standards/147">TDWG Standards Documentation Specification</a>.</p>
  <h1><a id="2">2 Vocabulary versions</a></h1>
  <p>To examine specific historical versions of this vocabulary, click on one of the links below.</p>
  <ul style="list-style: none;">{
    let $versions := fn:collection("vocabularies")/linked-metadata/file/metadata/record
    for $version in $versions
    where $version/vocabulary/text() = $vocabularyIri and exists($version/version) (: screen out other linked metadata not related to versions:)
    return <li><a href="{$version/version/text()}">{$version/version/text()}</a></li>
  }</ul>
  <h1><a id="3">3 Vocabulary distributions</a></h1>
  <p>This vocabulary is available in the formats or distribution methods listed in the table below.  Please note that distribution access URLs may be subject to change over time.  Therefore, it is preferable to request the abstract IRI of the resources and request the desired Content-type through content negotiation.</p>
  <table border="1">{
    let $iri := html:substring-before-last($vocabularyIri,"/")
    return (
    <tr><th>Description</th><th>IRI</th><th>Access URL</th></tr>,
    <tr><td>HTML file (this document)</td><td>{$iri||".htm"}</td><td><a href="{$iri||'.htm'}">{$iri||".htm"}</a></td></tr>,
    <tr><td>RDF/Turtle</td><td>{$iri||".ttl"}</td><td><a href="{$iri||'.ttl'}">{$iri||".ttl"}</a></td></tr>,
    <tr><td>RDF/XML</td><td>{$iri||".rdf"}</td><td><a href="{$iri||'.rdf'}">{$iri||".rdf"}</a></td></tr>,
    <tr><td>JSON-LD</td><td>{$iri||".json"}</td><td><a href="{$iri||'.json'}">{$iri||".json"}</a></td></tr>
    )
  }</table>
  <h1><a id="4">4 Term lists that are part of this vocabulary</a></h1>
</div>
};

(: Generate the HTML tables of metadata about the term lists in the vocabulary and returns them as a div element :)
declare function html:generate-vocabulary-html($vocabularyMetadata as element(),$vocabularyIri as xs:string) as element()
{
let $termLists := html:generate-vocabulary-term-list-members($vocabularyIri) (: generate sequence of term list IRIs that are in vocabulary:)
let $metadata := html:load-list-records($termLists,"term-lists") (: pull the metadata records for term lists in the sequence :)
(:let $replacements := fn:collection($db)/linked-metadata/file/metadata/record:)
  
return 
     <div>
       {
       for $record in $metadata
(:       let $version := $vocabularyIri||"version/"||substring-after($record/list_localName/text(),"/")||$record/list_modified/text() :)
       order by $record/list_localName/text()
       return (
         <table>{
         <tr><td><strong>Label:</strong></td><td>{$record/label/text()}</td></tr>,
         <tr><td><strong>list IRI:</strong></td><td><a href='{$record/list/text()}'>{$record/list/text()}</a></td></tr>,

(:         <tr><td><strong>List version IRI:</strong></td><td><a href='{$version}'>{$version}</a></td></tr>, :)

         <tr><td><strong>Modified:</strong></td><td>{$record/list_modified/text()}</td></tr>,
         <tr><td><strong>Description:</strong></td><td>{$record/description/text()}</td></tr>,
         
         if ($record/list_deprecated/text() != "")
         then (
         <tr><td><strong>Note:</strong></td><td>This list is no longer recommended for use.</td></tr>
         )
         else ()
         }</table>,<br/>
         )
       }
     </div>
};

(:--------------------------------------------------------------------------------------------------:)
(: Generate term lists web page ////////////////////////////////////////////////////////////////////:)
(:--------------------------------------------------------------------------------------------------:)

(: 1st level function :)

(: Generates web page for a term list; ; usually following the pattern http://rs.tdwg.org/{vocab}/{list}/ :)
declare function html:generate-term-list-html($termListIri as xs:string) as element()
{
let $listMetadata := html:load-metadata-record($termListIri,"term-lists")
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
    html:generate-list-toc-etc-html($termListIri),
    html:generate-list-html(html:find-list-dbname($termListIri),$ns)
   }</body>
</html>
};

(:--------------------------------------------------------------------------------------------------:)
(: 2nd level functions :)

(: Generates HTML metadata for a particular list and returns them as a div element :)
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

(: Generates the HTML for the middle section of the term list page and returns it as a div elelment :)
declare function html:generate-list-toc-etc-html($termListIri as xs:string) as element()
{
<div>
  <h1>Table of Contents</h1>
  <ul style="list-style: none;">
    <li><a href="#1">1 Introduction</a></li>
    <li><a href="#2">2 List versions</a></li>
    <li><a href="#3">3 List distributions</a></li>
    <li><a href="#4">4 Terms that are members of this list</a></li>
  </ul>
  <h1><a id="1">1 Introduction</a></h1>
  <p>This is a list of terms that may be part of a TDWG vocabulary.  If the terms on this list are defined by TDWG, the list corresponds to terms in a namespace whose IRI is listed in the header.  In the case where the terms are borrowed from a non-TDWG vocabulary, the list includes terms that are &quot;borrowed&quot; for inclusion in a TDWG vocabulary.  The list includes all &quot;current&quot; terms on the list, which may or may not be recommended for use.  Terms that are no longer recommended for use may have specified replacements - see the metadata about that specific term.</p>
  <p>For more information about the structure and version model of TDWG vocabularies, see the <a href="http://www.tdwg.org/standards/147">TDWG Standards Documentation Specification</a>.</p>
  <h1><a id="2">2 List versions</a></h1>
  <p>List versions are &quot;snapshots&quot; of the term list at a particular point in time. To examine specific historical versions of this list, click on one of the links below.</p>
  <ul style="list-style: none;">{
    let $versions := fn:collection("term-lists")/linked-metadata/file/metadata/record
    for $version in $versions
    where $version/list/text() = $termListIri
    return <li><a href="{$version/version/text()}">{$version/version/text()}</a></li>
  }</ul>
  <h1><a id="3">3 List distributions</a></h1>
  <p>This term list is available in the formats or distribution methods listed in the table below.  Please note that distribution access URLs may be subject to change over time.  Therefore, it is preferable to request the abstract IRI of the resources and request the desired Content-type through content negotiation.</p>
  <table border="1">{
    let $iri := html:substring-before-last($termListIri,"/")
    return (
    <tr><th>Description</th><th>IRI</th><th>Access URL</th></tr>,
    <tr><td>HTML file (this document)</td><td>{$iri||".htm"}</td><td><a href="{$iri||'.htm'}">{$iri||".htm"}</a></td></tr>,
    <tr><td>RDF/Turtle</td><td>{$iri||".ttl"}</td><td><a href="{$iri||'.ttl'}">{$iri||".ttl"}</a></td></tr>,
    <tr><td>RDF/XML</td><td>{$iri||".rdf"}</td><td><a href="{$iri||'.rdf'}">{$iri||".rdf"}</a></td></tr>,
    <tr><td>JSON-LD</td><td>{$iri||".json"}</td><td><a href="{$iri||'.json'}">{$iri||".json"}</a></td></tr>
    )
  }</table>
  <h1><a id="4">4 Terms that are members of this list</a></h1>
</div>
};

(: Generate the HTML tables of metadata about the terms in the list and returns them as a div element :)
declare function html:generate-list-html($db as xs:string,$ns as xs:string) as element()
{
let $metadata := fn:collection($db)/metadata/record
let $replacements := fn:collection($db)/linked-metadata/file/metadata/record
  
return 
     <div>
       {
       for $record in $metadata
       let $version := $record/term_isDefinedBy/text()||"version/"||$record/term_localName/text()||"-"||$record/term_modified/text()
       order by $record/term_localName/text()
       return (
         <table>{
         <tr><td><a id="{$record/term_localName/text()}"><strong>Term Name:</strong></a></td><td>{$ns||":"||$record/term_localName/text()}</td></tr>,
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
         
         if (contains($record/rdf_type/text(),"#"))
         then <tr><td><strong>Type:</strong></td><td>{substring-after($record/rdf_type/text(),"#")}</td></tr>
         else <tr><td><strong>Type:</strong></td><td>{$record/rdf_type/text()}</td></tr>,
         
         if ($record/term_deprecated/text() != "")
         then (
         <tr><td><strong>Note:</strong></td><td>This term is no longer recommended for use.</td></tr>
         )
         else (),
         
         if ($record/replaces_term/text() != "")
         then (
           <tr><td><strong>Replaces:</strong></td><td><a href='{$record/replaces_term/text()}'>{$record/replaces_term/text()}</a></td></tr>
           )
         else (),
         if ($record/replaces1_term/text() != "")
         then (
           <tr><td><strong>Replaces:</strong></td><td><a href='{$record/replaces1_term/text()}'>{$record/replaces1_term/text()}</a></td></tr>
           )
         else (),
         if ($record/replaces2_term/text() != "")
         then (
           <tr><td><strong>Replaces:</strong></td><td><a href='{$record/replaces2_term/text()}'>{$record/replaces2_term/text()}</a></td></tr>
           )
         else (),

         for $replacement in $replacements
         where $replacement/replaced_term_localName/text() = $record/term_localName/text()
         return <tr><td><strong>Is replaced by:</strong></td><td><a href='{$replacement/replacing_term/text()}'>{$replacement/replacing_term/text()}</a></td></tr>

         }</table>,<br/>
         )
       }
     </div>
};

(:--------------------------------------------------------------------------------------------------:)
(: Generate term list versions web page ////////////////////////////////////////////////////////////////////:)
(:--------------------------------------------------------------------------------------------------:)

(: 1st level function :)

(: Generates web page for term lists versions; usually following the pattern http://rs.tdwg.org/{vocab}/version/{term-list}/{iso-date} :)
declare function html:generate-term-list-version-html($termListVersionIri as xs:string) as element()
{
let $listMetadata := html:load-metadata-record($termListVersionIri,"term-lists-versions")
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
    html:generate-list-versions-toc-etc-html($termListVersionIri),
    html:generate-list-versions-html(html:find-list-version-dbname($termListIri),$ns,$members)
   }</body>
</html>
};

(:--------------------------------------------------------------------------------------------------:)
(: 2nd level functions :)

(: Generates metadata for a list version and returns it as an HTML div element :)
declare function html:generate-list-versions-metadata-html($record as element(),$std as xs:string,$termListIri as xs:string) as element()
{
let $replacements := fn:collection("term-lists-versions")/linked-metadata/file/metadata/record
return
<div>{
  <strong>Title: </strong>,<span>{$record/label/text()||" (version)"}</span>,<br/>,
  <strong>Issued: </strong>,<span>{$record/version_modified/text()}</span>,<br/>,

  if ($std != "")
  then (
    <strong>Part of TDWG Standard: </strong>,<a href='{$std}'>{$std}</a>,<br/>
    )
  else (
    <span>Not part of any TDWG Standard</span>,<br/>
    ),
  
  <strong>This version: </strong>,<a href='{$record/version/text()}'>{$record/version/text()}</a>,<br/>,
  <strong>Latest version: </strong>,<a href='{$termListIri}'>{$termListIri}</a>,<br/>,
  
  for $replacement in $replacements
  where $replacement/replacing_list/text() = $record/version/text()
  return (<strong>Previous version:</strong>,<a href='{$replacement/replaced_list/text()}'>{$replacement/replaced_list/text()}</a>,<br/>),

  for $replacement in $replacements
  where $replacement/replaced_list/text() = $record/version/text()
  return (<strong>Replaced by:</strong>,<a href='{$replacement/replacing_list/text()}'>{$replacement/replacing_list/text()}</a>,<br/>),

  <strong>Abstract: </strong>,<span>This version lists the member terms on the date that the list was issued.  The status shown for the term version is its current status.</span>,<br/>,
  
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

(: Generates the HTML for the middle section of the term list versions page and returns it as a div elelment :)
declare function html:generate-list-versions-toc-etc-html($termListVersionIri as xs:string) as element()
{
<div>
  <h1>Table of Contents</h1>
  <ul style="list-style: none;">
    <li><a href="#1">1 Introduction</a></li>
    <li><a href="#2">2 List distributions</a></li>
    <li><a href="#3">3 Term versions that were members of this list when it was issued</a></li>
  </ul>
  <h1><a id="1">1 Introduction</a></h1>
  <p>This is a list of term versions that may be part of a TDWG vocabulary.  If the terms whose versions are on this list were defined by TDWG, the list corresponds to term versions in a namespace whose IRI is listed in the header.  In the case where the terms were borrowed from a non-TDWG vocabulary, the list includes term versions that were &quot;borrowed&quot; for inclusion in a TDWG vocabulary.</p>
  <p>This list includes term versions that were part of the term list at the time this version was issued.  The status of the individual terms may have changed since the version was issued.  The version status indicates its status at the present time, not at the time the list version was issued.</p>
  <p>For more information about the structure and version model of TDWG vocabularies, see the <a href="http://www.tdwg.org/standards/147">TDWG Standards Documentation Specification</a>.</p>
  <h1><a id="2">2 List distributions</a></h1>
  <p>This term versions list is available in the formats or distribution methods listed in the table below.  Please note that distribution access URLs may be subject to change over time.  Therefore, it is preferable to request the abstract IRI of the resources and request the desired Content-type through content negotiation.</p>
  <table border="1">{
    let $iri := $termListVersionIri
    return (
    <tr><th>Description</th><th>IRI</th><th>Access URL</th></tr>,
    <tr><td>HTML file (this document)</td><td>{$iri||".htm"}</td><td><a href="{$iri||'.htm'}">{$iri||".htm"}</a></td></tr>,
    <tr><td>RDF/Turtle</td><td>{$iri||".ttl"}</td><td><a href="{$iri||'.ttl'}">{$iri||".ttl"}</a></td></tr>,
    <tr><td>RDF/XML</td><td>{$iri||".rdf"}</td><td><a href="{$iri||'.rdf'}">{$iri||".rdf"}</a></td></tr>,
    <tr><td>JSON-LD</td><td>{$iri||".json"}</td><td><a href="{$iri||'.json'}">{$iri||".json"}</a></td></tr>
    )
  }</table>
  <h1><a id="3">3 Term versions that were members of this list when it was issued</a></h1>
</div>
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
         <tr><td><a name="{$ns||"_"||$record/term_localName/text()}"><strong>Term Name:</strong></a></td><td>{$ns||":"||$record/term_localName/text()}</td></tr>,
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
    <title>Test</title>
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
