xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";

(: ----------------------------------------- :)
(: function declarations :)
(: ----------------------------------------- :)

(: function from http://www.xqueryfunctions.com/xq/functx_trim.html :)
declare function local:trim
  ( $arg as xs:string? )  as xs:string {

   replace(replace($arg,'\s+$',''),'^\s+','')
 } ;
 
declare function local:loadCsvInternet($uri as xs:string, $delimiter as xs:string, $header as xs:boolean) as element()*
{
(: See https://github.com/HeardLibrary/digital-scholarship/tree/master/code/file for more on this function. :)

let $csvDoc := http:send-request(<http:request method='get' href='{$uri}'/>)[2] (: ignore initial response element :)
let $xmlDoc := csv:parse($csvDoc, map { 'header' : $header,'separator' : $delimiter })

return $xmlDoc/csv/record
};

declare function local:createNamesIndex($headerMap)
{
for $nameColumn in $headerMap
let $columnString := $nameColumn/string/string()
let $leftOfDot := tokenize($columnString,'\.')[1]
let $langCode := tokenize($columnString,'\.')[2]
return if (string-length($leftOfDot) = 5 and substring(tokenize($columnString,'\.')[1],1,4) = 'name') then
  <name>{
    <langCode>{$langCode}</langCode>,
    <labelColumnElementName>{$nameColumn/name/string()}</labelColumnElementName>,
    
    for $uriColumn in $headerMap   (: find the element name of the sourceURI column :)
    return if ($uriColumn/string/string() = 'sourceURI.'||$leftOfDot)
           then <sourceUriElementName>{$uriColumn/name/string()}</sourceUriElementName>
           else (),
    for $pagesColumn in $headerMap   (: find the element name of the sourceURI column :)
    return if ($pagesColumn/string/string() = 'pages.'||$leftOfDot)
           then <pagesElementName>{$pagesColumn/name/string()}</pagesElementName>
           else ()
  }</name>
else 
 ()
};

declare function local:createHeadwordIndex($headerMap)
{
for $nameColumn in $headerMap
let $columnString := $nameColumn/string/string()
let $leftOfDot := tokenize($columnString,'\.')[1]
let $langCode := tokenize($columnString,'\.')[2]
return if (substring(tokenize($columnString,'\.')[1],1,12) = 'nameHeadword') then
  <headword>{
    <langCode>{$langCode}</langCode>,
    <labelColumnElementName>{$nameColumn/name/string()}</labelColumnElementName>
  }</headword>
else 
 ()
};

declare function local:createAbstractIndex($headerMap)
{
for $nameColumn in $headerMap
let $columnString := $nameColumn/string/string()
let $leftOfDot := tokenize($columnString,'\.')[1]
let $langCode := tokenize($columnString,'\.')[2]
return if (substring(tokenize($columnString,'\.')[1],1,8) = 'abstract') then
  <abstract>{
    <langCode>{$langCode}</langCode>,
    <labelColumnElementName>{$nameColumn/name/string()}</labelColumnElementName>
  }</abstract>
else 
 ()
};


(: ----------------------------------------- :)
(: Start of script :)
(: ----------------------------------------- :)

(: This part of the script loads the data from GitHub and creates a mapping between the column header strings and the elements in the data XML:)
let $url := "https://raw.githubusercontent.com/srophe/draft-data/master/data/TSVTransformsXQuery/placesToTransform.tsv"
let $delimiter := '&#9;' (: tab character, change if a different delimiter like comma is used :)
let $baseLanguage := 'en'

let $listBibl := 
<listBibl xmlns:tei="http://www.tei-c.org/ns/1.0">
    <bibl>
        <ptr target="#bib75-2"/>
    </bibl>
    <bibl>
        <ptr target="#bib75-3"/>
    </bibl>
    <bibl>
        <ptr target="#bib75-4"/>
    </bibl>
</listBibl>

let $columnHeaders := local:loadCsvInternet($url,$delimiter,false())[1]/entry/text() (: load the TSV without headers, then pull text from 1st (header) row :)

(: Each row from the TSV table is read in as a record element like this.  $data is a sequence of these record elements.

<record>
  <New_place_add_data>new place</New_place_add_data>
  <uri>75</uri>
  <Possible_URI/>
  <nameHeadword.en>Doliche</nameHeadword.en>
  <nameHeadword.syr>ܕܠܘܟ</nameHeadword.syr>
...
</record>

Note that the element names differ from the column headers in that spaces, slashes, etc. may be replaced with underscores.  
:)
let $data := local:loadCsvInternet($url,$delimiter,true()) (: load the TSV with headers.  Headers are used as tag names subject to cleanup to make valid XML element names :)

let $columnElementNames := $data[1]/*/name()

(:
$headerMap is a sequence that looks like this.  It relates the strings used in the TSV column headers to the XML tag names in the data

<map>
  <string>New place/add data</string>
  <name>New_place_add_data</name>
</map>
<map>
  <string>uri</string>
  <name>uri</name>
</map>
<map>
  <string>Possible URI</string>
  <name>Possible_URI</name>
</map>
...

:)
let $headerMap := 
                  for $x at $pos in $columnHeaders
                  return (<map>{<string>{$x}</string>,<name>{$columnElementNames[$pos]}</name>}</map>)

(:
$namesIndex is a sequence looks like this:

<name>
  <langCode>en</langCode>
  <labelColumnElementName>name2.en</labelColumnElementName>
  <sourceUriElementName>sourceURI.name2</sourceUriElementName>
  <pagesElementName>pages.name2</pagesElementName>
</name>
<name>
  <langCode>syr</langCode>
  <labelColumnElementName>name3.syr</labelColumnElementName>
  <sourceUriElementName>sourceURI.name3</sourceUriElementName>
  <pagesElementName>pages.name3</pagesElementName>
</name>

:)
let $namesIndex := local:createNamesIndex($headerMap) (: find and process the names columns :)

(:
$headwordIndex is a sequence looks like this:

<headword>
  <langCode>en</langCode>
  <labelColumnElementName>nameHeadword.en</labelColumnElementName>
</headword>
<headword>
  <langCode>syr</langCode>
  <labelColumnElementName>nameHeadword.syr</labelColumnElementName>
</headword>

:)
let $headwordIndex := local:createHeadwordIndex($headerMap) (: find and process the headwords columns :)

(:
$abstractIndex is a sequence looks like this:

<abstract>
  <langCode>en</langCode>
  <labelColumnElementName>abstract.en</labelColumnElementName>
</abstract>

In the current system, there is only one English abstract, but this allows for a different language or multiple abstracts in different languages
:)
let $abstractIndex := local:createAbstractIndex($headerMap) (: find and process the abstracts columns :)

(: ----------------------------------------- :)
(: set up the loop that generates a document for each row in the TSV file :)

for $document at $row in $data
where $row = 2  (: comment out this row when testing is done :)
return

(: ----------------------------------------- :)
(: This part of the script builds the TEI header element from inner parts outward :)
let $date := current-date()

let $uriLocalName := local:trim($document/uri/text())

let $availability :=
  <availability xmlns:tei="http://www.tei-c.org/ns/1.0">
      <licence target="http://creativecommons.org/licenses/by/3.0/">
          <p>Distributed under a Creative Commons Attribution 3.0 Unported License.</p>
          <p>This entry incorporates copyrighted material from the following work(s):
          {$listBibl}
              <note>used under a Creative Commons Attribution license <ref target="http://creativecommons.org/licenses/by/3.0/"/>
              </note>
          </p>
      </licence>
  </availability>

let $pubStatement :=
  <publicationStmt xmlns:tei="http://www.tei-c.org/ns/1.0">
      <authority>Syriaca.org: The Syriac Reference Portal</authority>,
      <idno type="URI">http://syriaca.org/place/{$uriLocalName}/tei</idno>,
      {$availability},
      <date>{$date}</date>
  </publicationStmt>

let $title :=
    for $baseLanguageHeadword in $headwordIndex
    where $baseLanguageHeadword/langCode/text() = $baseLanguage
    let $bltag := $baseLanguageHeadword/langCode/text()
    let $blabel := local:trim($document/*[name() = $baseLanguageHeadword/labelColumnElementName/text()]/text())
    return 
         <title xmlns:tei="http://www.tei-c.org/ns/1.0" level="a" xml:lang="{$bltag}">{$blabel}
              — {
                    for $foreignHeadword in $headwordIndex
                    where $foreignHeadword/langCode/text() != $baseLanguage
                    let $fltag := $baseLanguageHeadword/langCode/text()
                    let $flabel := local:trim($document/*[name() = $foreignHeadword/labelColumnElementName/text()]/text())
                    return <foreign xml:lang="{$foreignHeadword/langCode/text()}">{$flabel}</foreign>
        }</title>
    
let $titleStatement := 
  <titleStmt xmlns:tei="http://www.tei-c.org/ns/1.0">{
      $title,
      <sponsor>Syriaca.org: The Syriac Reference Portal</sponsor>,
      <funder>The National Endowment for the Humanities</funder>,
      <funder>The International Balzan Prize Foundation</funder>,
      <editor role="creator" ref="http://syriaca.org/documentation/editors.xml#dschwartz">Daniel L. Schwartz</editor>,
      <respStmt>
          <resp>URI minted and initial data collected by</resp>
          <name ref="http://syriaca.org/documentation/editors.xml#dschwartz">Daniel L. Schwartz</name>
      </respStmt>
  }</titleStmt>

let $fileDesc := 
  <fileDesc xmlns:tei="http://www.tei-c.org/ns/1.0">{
      $titleStatement,
      <editionStmt>
          <edition n="1.0"/>
      </editionStmt>,
      $pubStatement,
      <seriesStmt>
          <title level="s" xml:lang="en">The Syriac Gazetteer</title>
          <editor role="general" ref="http://syriaca.org/documentation/editors.xml#tcarlson">Thomas A. Carlson</editor>
          <editor role="general" ref="http://syriaca.org/documentation/editors.xml#dmichelson">David A. Michelson</editor>
          <idno type="URI">http://syriaca.org/geo</idno>
      </seriesStmt>,
      <sourceDesc>
          <p>Born digital.</p>
      </sourceDesc>
  }</fileDesc>
  
let $header :=
    <teiHeader xmlns:tei="http://www.tei-c.org/ns/1.0">{
      $fileDesc,
      <encodingDesc>
          <editorialDecl>
              <p>This record created following the Syriaca.org guidelines. Documentation available at: <ref target="http://syriaca.org/documentation">http://syriaca.org/documentation</ref>.</p>
              <p>The <gi>state</gi> element of @type="existence" indicates the period for which this place was in use as a place of its indicated type (e.g. an inhabited settlement, a functioning monastery or church, an administrative province).  Natural features always in existence have no <gi>state</gi> element of @type="existence".</p>
          </editorialDecl>
          <classDecl>
              <taxonomy>
                  <category xml:id="syriaca-headword">
                      <catDesc>The name used by Syriaca.org for document titles, citation, and disambiguation. These names have been created according to the Syriac.org guidelines for headwords: <ref target="http://syriaca.org/documentation/headwords.html">http://syriaca.org/documentation/headwords.html</ref>.</catDesc>
                  </category>
              </taxonomy>
          </classDecl>
      </encodingDesc>,
      <profileDesc>
          <langUsage>
              <p>
                  Languages codes used in this record follow the Syriaca.org guidelines. Documentation available at: 
                  <ref target="http://syriaca.org/documentation/langusage.xml">http://syriaca.org/documentation/langusage.xml</ref>
              </p>
          </langUsage>
      </profileDesc>,
      <revisionDesc status="draft">
          <change who="http://syriaca.org/documentation/editors.xml#dschwartz" when="{$date}">CREATED: place</change>
      </revisionDesc>

  }</teiHeader>       

(: ----------------------------------------- :)
(: This part of the script builds the text element from inner parts outward :)

(: create an empty source sequence :)

let $redundantSources := ()

(: Find every possible reference in the row and add it to a sequence :)

for $source in $headerMap  (: loop through each item in the header map sequence :)
  let $sourceUriColumnName := $source/name/text()  (: get the XML element name :)
  let $sourceUri := local:trim($document/*[name() = $sourceUriColumnName]/text())  (: find the value for that column :)
  where substring($source/string/text(),1,9) = 'sourceURI' and $sourceUri != '' (: screen for right header string and skip over empty elements :)
  let $lastPartColString := substring($source/string/text(),10)  (: find the last part of the sourceUri column header label :)
  let $sourcePgColumnString := 'pages'||$lastPartColString  (: construct the column label for the page source :)
  let $sourcePgColumnName :=
      for $sourcePage in $headerMap    (: find the column string that matches the constructed on :)
      where $sourcePgColumnString = $sourcePage/string/text()
      return $sourcePage/name/text()     (: return the XML tag name for the matching column string :)
  let $sourcePage := local:trim($document/*[name() = $sourcePgColumnName]/text())
  let $redundantSources := insert-before($redundantSources,0,($sourceUri,$sourcePage))
  return $redundantSources