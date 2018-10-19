xquery version "3.1";

declare namespace bio = "http://www.github.com/biosemantics";
declare namespace bios = "http://www.github.com/biosemantics/";
declare namespace functx = "http://www.functx.com";
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace rdfs = "http://www.w3.org/2000/01/rdf-schema#";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace dcterms = "http://purl.org/dc/terms/";
declare namespace dwc = "http://rs.tdwg.org/dwc/terms/";

declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? {

   concat(upper-case(substring($arg,1,1)),
             substring($arg,2))
 } ;

let $namespace := "http://fna.org/treatment/"

let $data := doc('V6_1.xml')/bio:treatment

(: metadata :)
let $author := $data/meta/source/author/text()
let $sourceDate := $data/meta/source/date/text()
let $treatmentPage := $data/meta/other_info_on_meta[@type="treatment_page"]/text()
(: Note: There can be multiple mention pages :)
let $mentionPage := $data/meta/other_info_on_meta[@type="treatment_page"]/text()
let $volume := $data/meta/other_info_on_meta[@type="volume"]/text()
let $illustrator := $data/meta/other_info_on_meta[@type="illustrator"]/text()

(: taxon information :)
let $taxonomicStatus := lower-case(string($data/taxon_identification/@status))
let $taxonRank := string($data/taxon_identification/taxon_name/@rank)
let $taxonAuthority := string($data/taxon_identification/taxon_name/@authority)
let $taxonDate := string($data/taxon_identification/taxon_name/@date)
let $taxonName := functx:capitalize-first(lower-case($data/taxon_identification/taxon_name/text()))
let $number := $data/number/text()

let $morphologyDescription := $data/description[@type="morphology"]/text()
let $distributionDescription := $data/description[@type="distribution"]/text()

(: concatenate all of the sentences in the discussion elements into a single string :)
let $discussions := $data/discussion
let $discussion := string-join($discussions," ")

(: Note: there are multiple references :)
let $references := $data/references/reference/text()

let $keyStatements := $data/key/key_statement

return 

(file:write("Documents/github/msc/fna/output.rdf",

<rdf:RDF 
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:bios="http://www.github.com/biosemantics/"
>
    <rdf:Description rdf:about = "{$namespace||$number}">{
         <rdf:type rdf:resource="http://www.github.com/biosemantics/Treatment" />,
         <rdfs:label>{$taxonName}</rdfs:label>,
         <dc:creator>{$author}</dc:creator>,
         if ($sourceDate  != "")
             then <dcterms:created>{$sourceDate}</dcterms:created>
             else (),
         <dcterms:identifier>{$number}</dcterms:identifier>,
(:         <dcterms:source rdf:nodeID="{$sourceNodeID}" />,:)
         <dwc:scientificName>{$taxonName}</dwc:scientificName>,
         <dwc:taxonRank>{$taxonRank}</dwc:taxonRank>,
         <dwc:scientificNameAuthorship>{$taxonAuthority}</dwc:scientificNameAuthorship>,
         <dcterms:date>{$taxonDate}</dcterms:date>,
         <dwc:taxonomicStatus>{$taxonomicStatus}</dwc:taxonomicStatus>,
         <bios:morphology>{$morphologyDescription}</bios:morphology>,
         <bios:distribution>{$distributionDescription}</bios:distribution>,
         <dcterms:description>{$discussion}</dcterms:description>,
    
         for $reference in $references
         return <dcterms:references>{$reference}</dcterms:references>,
         
         <bios:nextCouplet rdf:resource="{$namespace||$number||'#1'}"/>,
         
         let $couplets := 
             for tumbling window $w in $keyStatements
               start at $s when true()
               only end at $e when $e - $s eq 1
             return <couplet>{$w}</couplet>
         for $couplet in $couplets
         let $statements := $couplet/key_statement
         return 
             <bios:hasCouplet>{
               <rdf:Description rdf:about="{$namespace||$number||'#'||$statements[1]/statement_id/text()}">{
                  <bios:coupletNumber>{$statements[1]/statement_id/text()}</bios:coupletNumber>,
                  for $statement in $statements
                  return 
                      <bios:hasStatement>
                        <rdf:Description>{
                            <bios:statementText>{$statement/description/text()}</bios:statementText>,
                            <rdfs:label>{$statement/description/text()}</rdfs:label>,
                            
                             if ($statement/next_statement_id)
                             then <bios:nextCouplet rdf:resource="{$namespace||$number||'#'||$statement/next_statement_id/text()}"/>
                             else (),
                             
                             if ($statement/determination)
                             then <bios:determination>{$statement/determination/text()}</bios:determination>
                             else ()
                                    
                         }</rdf:Description>
                      </bios:hasStatement>
               }</rdf:Description>
             }</bios:hasCouplet>
         
    }</rdf:Description> 
</rdf:RDF>

))
