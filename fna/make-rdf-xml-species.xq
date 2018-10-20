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

declare function functx:trim
  ( $arg as xs:string? )  as xs:string {

   replace(replace($arg,'\s+$',''),'^\s+','')
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
                        <rdf:type resource="http://www.github.com/biosemantics/MinorPart"/>
                        <bios:minorName>{$minorPartName}</bios:minorName>
                        <bios:minorDescription>{$minorPartDescription}</bios:minorDescription>
                    </rdf:Description>
                </bios:hasMinorPart>
      return
      <bios:hasMajorPart>
          <rdf:Description>
              <rdf:type resource="http://www.github.com/biosemantics/MajorPart"/>
              <bios:majorName>{$majorPartName}</bios:majorName>
              <bios:majorDescription>{$majorPartDescription}</bios:majorDescription>
              {if (count($minorPart)!=0)
              then $minorPart
              else ()}
          </rdf:Description>
      </bios:hasMajorPart>
};

let $namespace := "http://fna.org/treatment/"

let $data := doc('V6_5.xml')/bio:treatment

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
         <rdfs:label>{$label}</rdfs:label>,
         <dc:creator>{$author}</dc:creator>,
         if ($sourceDate  != "")
             then <dcterms:created>{$sourceDate}</dcterms:created>
             else (),
         <dcterms:identifier>{$number}</dcterms:identifier>,
         if ($illustrationPage != "")
         then <bios:illustrationPage>{$illustrationPage}</bios:illustrationPage>
         else (),
         <bios:treatmentPage>{$treatmentPage}</bios:treatmentPage>,
         <bios:volume>{$volume}</bios:volume>,
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
                 for $namePart in $taxon/taxon_name
                 return <bios:hasPart>
                      <rdf:Description>{
                        <dwc:taxonRank>{string($namePart/@rank)}</dwc:taxonRank>,
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

    }</rdf:Description> 
</rdf:RDF>

))
