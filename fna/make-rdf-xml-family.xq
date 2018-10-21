xquery version "3.1";

declare namespace bio = "http://www.github.com/biosemantics";
declare namespace bios = "http://www.github.com/biosemantics/";
declare namespace functx = "http://www.functx.com";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace rdfs = "http://www.w3.org/2000/01/rdf-schema#";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace dcterms = "http://purl.org/dc/terms/";
declare namespace dwc = "http://rs.tdwg.org/dwc/terms/";

(: functions borrowed from FunctX (http://www.xqueryfunctions.com/xq/) :)
declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? {

   concat(upper-case(substring($arg,1,1)),
             substring($arg,2))
 } ;

declare function functx:trim
  ( $arg as xs:string? )  as xs:string {

   replace(replace($arg,'\s+$',''),'^\s+','')
 } ;
 
declare function functx:is-value-in-sequence
  ( $value as xs:anyAtomicType? ,
    $seq as xs:anyAtomicType* )  as xs:boolean {

   $value = $seq
 } ;
 
declare function local:parse-morphology($text as xs:string) as node()* {
  let $majorParts := tokenize($text,"\. ")
  for $majorPart in $majorParts
      let $majorPartName := lower-case(translate(functx:trim(tokenize($majorPart," ")[1]), ':', ''))
      let $remainder := functx:trim(string-join(subsequence(tokenize($majorPart," "),2)," "))
      let $majorPartDescription := functx:trim(tokenize($remainder,";")[1])
      let $minorRemainder := subsequence(tokenize($remainder,";"),2)
      let $minorPart := 
            for $minorPart in $minorRemainder
                let $minorPartName := functx:trim(tokenize($minorPart," ")[2])
                let $minorPartDescription := functx:trim(string-join(subsequence(tokenize($minorPart," "),3)," "))
                return
                <bios:hasMinorPart>
                    <rdf:Description>
                        <rdf:type rdf:resource="http://www.github.com/biosemantics/MinorPart"/>
                        <bios:minorName>{$minorPartName}</bios:minorName>
                        <bios:minorDescription>{$minorPartDescription}</bios:minorDescription>
                    </rdf:Description>
                </bios:hasMinorPart>
      return
      <bios:hasMajorPart>
          <rdf:Description>
              <rdf:type rdf:resource="http://www.github.com/biosemantics/MajorPart"/>
              <bios:majorName>{$majorPartName}</bios:majorName>
              <bios:majorDescription>{$majorPartDescription}</bios:majorDescription>
              {if (count($minorPart)!=0)
              then $minorPart
              else ()}
          </rdf:Description>
      </bios:hasMajorPart>
};

declare function local:parse-determination($namespace, $number, $text as xs:string? ) {
  let $childTaxonNumber := functx:trim(tokenize($text," ")[1])
  let $childTaxonName := functx:trim(subsequence(tokenize($text," "),2))
  return
     <rdf:Description rdf:about="{$namespace||$number||'#'||$childTaxonName}">{
        <bios:childTaxonNumber>{$childTaxonNumber}</bios:childTaxonNumber>,
        <rdfs:label>{$childTaxonName}</rdfs:label>
     }</rdf:Description>
 } ;

declare function local:find-lowest-rank($taxon as node()+) as xs:string {
  let $rankSequence :=
    for $namePart in $taxon/taxon_name
    return string($namePart/@rank)
  return
    if (functx:is-value-in-sequence("variety",$rankSequence))
    then "variety"
    else if (functx:is-value-in-sequence("subspecies",$rankSequence))
        then "subspecies"
        else if (functx:is-value-in-sequence("species",$rankSequence))
            then "species"
            else if (functx:is-value-in-sequence("genus",$rankSequence))
                then "genus"
                else if (functx:is-value-in-sequence("family",$rankSequence))
                    then "family"
                    else "rank not found"
};
 
let $namespace := "http://fna.org/treatment/"

let $data := doc('V6_1.xml')/bio:treatment

(: metadata :)
let $author := $data/meta/source/author/text()
let $sourceDate := $data/meta/source/date/text()
let $treatmentPage := $data/meta/other_info_on_meta[@type="treatment_page"]/text()
let $illustrationPage := $data/meta/other_info_on_meta[@type="illustration_page"]/text()
(: Note: There can be multiple mention pages :)
let $mentionPages := $data/meta/other_info_on_meta[@type="mention_page"]/text()
let $volume := $data/meta/other_info_on_meta[@type="volume"]/text()
let $illustrator := $data/meta/other_info_on_meta[@type="illustrator"]/text()

(: taxon information :)
let $taxa := $data/taxon_identification

(: Create a label by concatenating the accepted name parts :)
let $label :=
  for $taxon in $taxa
  where string($taxon/@status) = "ACCEPTED"
  return string-join($taxon/taxon_name/text()," ")
let $number := $data/number/text()

let $morphologyDescription := $data/description[@type="morphology"]/text()
let $phenologyDescription := $data/description[@type="phenology"]/text()
let $habitatDescription := $data/description[@type="habitat"]/text()
let $elevationDescription := $data/description[@type="elevation"]/text()
let $distributionDescription := $data/description[@type="distribution"]/text()

(: concatenate all of the sentences in the discussion elements into a single string :)
let $discussions := $data/discussion
let $discussion := string-join($discussions," ")

(: Note: there are multiple references :)
let $references := $data/references/reference/text()

let $keyStatements := $data/key/key_statement

return 

(file:write("c:/github/msc/fna/output.rdf",

<rdf:RDF 
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:bios="http://www.github.com/biosemantics/"
>{
    <rdf:Description rdf:about = "{$namespace||$number}">{
         <rdf:type rdf:resource="http://www.github.com/biosemantics/Treatment" />,
         <rdfs:label>{$label}</rdfs:label>,
         <dcterms:identifier>{$number}</dcterms:identifier>,
         <dc:creator>{$author}</dc:creator>,
         <bios:treatmentPage>{$treatmentPage}</bios:treatmentPage>,
         <bios:volume>{$volume}</bios:volume>,
         if ($sourceDate  != "")
             then <dcterms:created>{$sourceDate}</dcterms:created>
             else (),
         if ($illustrationPage != "")
         then <bios:illustrationPage>{$illustrationPage}</bios:illustrationPage>
         else (),
         if ($illustrator != "")
         then <bios:illustrator>{$illustrator}</bios:illustrator>
         else (),
         
         for $mentionPage in $mentionPages
         return <bios:mentionPage>{$mentionPage}</bios:mentionPage>,

         for $taxon in $taxa
         return
             <bios:hasName>
               <rdf:Description>{
                 <dwc:taxonomicStatus>{lower-case($taxon/@status)}</dwc:taxonomicStatus>,
                 <bios:taxonHierarchy>{$taxon/taxon_hierarchy/text()}</bios:taxonHierarchy>,
                 <dwc:taxonRank>{local:find-lowest-rank($taxon)}</dwc:taxonRank>,
                 for $namePart in $taxon/taxon_name
                 return <bios:hasPart>
                      <rdf:Description>{
                        <bios:namePartRank>{string($namePart/@rank)}</bios:namePartRank>,
                        <dwc:scientificNameAuthorship>{string($namePart/@authority)}</dwc:scientificNameAuthorship>,
                        <dcterms:date>{string($namePart/@date)}</dcterms:date>,
                        <dwc:scientificName>{
                        (: for whatever reason, the capitalization of names is inconsistent, so fix them :)
                        switch (string($namePart/@rank))
                            case "family" return functx:capitalize-first(lower-case($namePart/text()))
                            case "genus" return functx:capitalize-first(lower-case($namePart/text()))
                            default return lower-case($namePart/text())
                        }</dwc:scientificName>
                      }</rdf:Description>
                   </bios:hasPart>
               }</rdf:Description>
             </bios:hasName>,

         <bios:morphology>{$morphologyDescription}</bios:morphology>,
         <bios:distribution>{$distributionDescription}</bios:distribution>,
         if ($phenologyDescription != "")
         then <bios:phenology>{$phenologyDescription}</bios:phenology>
         else (),
         if ($habitatDescription != "")
         then <bios:habitat>{$habitatDescription}</bios:habitat>
         else (),
         if ($elevationDescription != "")
         then <bios:elevation>{$elevationDescription}</bios:elevation>
         else (),
         local:parse-morphology($morphologyDescription),

         <dcterms:description>{$discussion}</dcterms:description>,
    
         for $reference in $references
         return <dcterms:references>{$reference}</dcterms:references>
    }</rdf:Description>,
    
     (: create the links from one key node to the next :)
     for $keyStatement in $keyStatements
     return
         if ($keyStatement/statement_id/text()="1")
         then
             (: the first node is the treatment itself :)
             <rdf:Description rdf:about="{$namespace||$number}">{
                  <bios:nextNode rdf:resource="{$namespace||$number||'#'||$keyStatement/next_statement_id/text()}"/>
               }</rdf:Description>
         else
             if ($keyStatement/determination)
             then
               <rdf:Description rdf:about="{$namespace||$number||'#'||$keyStatement/statement_id/text()}">{
                 <bios:nextNode rdf:resource="{$namespace||$number||'#'||functx:trim(subsequence(tokenize($keyStatement/determination/text()," "),2))}"/>
               }</rdf:Description>

             else
               <rdf:Description rdf:about="{$namespace||$number||'#'||$keyStatement/statement_id/text()}">{
                  <bios:nextNode rdf:resource="{$namespace||$number||'#'||$keyStatement/next_statement_id/text()}"/>
               }</rdf:Description>,

               
         (: link information to the key nodes :)
         for $keyStatement in $keyStatements
         return
               if ($keyStatement/determination)
               then local:parse-determination($namespace, $number, $keyStatement/determination/text())
               else
               <rdf:Description rdf:about="{$namespace||$number||'#'||$keyStatement/next_statement_id/text()}">{
                  <bios:nodeNumber>{$keyStatement/next_statement_id/text()}</bios:nodeNumber>,
                  <rdfs:label>{$keyStatement/description/text()}</rdfs:label>
               }</rdf:Description>

         
}</rdf:RDF>

))
