xquery version "3.1";

(: Note: I had to run this at the command line, with additional allocated memory because I ran out of main memory via the BaseX GUI :)

declare namespace functx = "http://www.functx.com";
declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? {

   concat(upper-case(substring($arg,1,1)),
             substring($arg,2))
 } ;

declare function local:get-taxonomy($tags as xs:string*) as element()
{
<taxonomy>{
        for $tag in $tags
        where contains($tag,":")
        let $key := substring-before($tag,":")
        let $keyLength := string-length($key)
        return
            if ($key = "taxonomy" or $key = "Taxonomy" or $key = "axonomy" or $key = "hederaceataxonomy" or $key = "onomy" or $key = "raxonomy" or $key = "rtaxonomy" or $key = "taconomy" or $key = "taonomy" or $key = "taoxnomy" or $key = "taxacom" or $key = "taxnomy" or $key = "taxomomy" or $key = "taxonbomy" or $key = "taxonimy" or $key = "taxoniomy" or $key = "taxonmomy" or $key = "taxonmy" or $key = "taxonoimy" or $key = "taxonom" or $key = "taxonomny" or $key = "taxonomomy" or $key = "taxonomyL" or $key = "taxonony" or $key = "taxonopmy" or $key = "taxonoy" or $key = "taxoomy" or $key = "taxopnomy" or $key = "traxaonomy" or $key = "ttaxonomy" or $key = "txaonomy")
            then
                let $taxonLevel := substring-before(substring-after($tag,$key||":"),'=')
                let $taxonValue := substring-after(substring-after($tag,$key||":"),'=')
                return
                    if ($taxonLevel='kingdom' or $taxonLevel='phylum' or $taxonLevel='class' or $taxonLevel='order' or $taxonLevel='family' or $taxonLevel='genus')
                    then 
                        element {$taxonLevel} {functx:capitalize-first($taxonValue)}
                    else if ($taxonLevel='binomial')
                    then
                        let $t := ''
                        return element {$taxonLevel} {$taxonValue}
                    else
                        element {$taxonLevel} {$taxonValue}
            else ()
}</taxonomy>
};

declare function local:getEpithets($taxonomy as element()) as element()
{
  let $specificEpithet := substring-after($taxonomy/binomial[1]/text(),lower-case($taxonomy/genus[1]/text()))
  let $infraspecificEpithet := substring-after($taxonomy/trinomial[1]/text(),lower-case($taxonomy/binomial[1]/text()))
  return 
    <taxonomy>
      {$taxonomy/kingdom}
      {$taxonomy/phylum}
      {$taxonomy/class}
      {$taxonomy/order}
      {$taxonomy/family}
      {$taxonomy/genus}
      {
      if ($specificEpithet!='')
      then <specificEpithet>{$specificEpithet}</specificEpithet>
      else ()
      }
      {
      if ($infraspecificEpithet!='')
      then <infraspecificEpithet>{$infraspecificEpithet}</infraspecificEpithet>
      else ()
      }
      {$taxonomy/common}
    </taxonomy>
};

declare function local:get-geography($tags as xs:string*) as element()*
{
  for $tag in $tags
  where contains($tag,":")
  let $key := substring-before($tag,":")
  let $keyLength := string-length($key)
  return
      if ($key="geo" or $key="victoriageocode" or $key="Geocode" or $key="eocode" or $key="geocode" or $key="gecode" or $key="geocoded" or $key="geocoue" or $key="geoicode" or $key="geoo" or $key="geoode" or $key="geopcode" or $key="gepo" or $key="gepocode")
      then
          let $geoTag := substring-before(substring-after($tag,$key||":"),'=')
          let $geoValue := substring-after(substring-after($tag,$key||":"),'=')
          return
                  element {$geoTag} {$geoValue}
      else ()  
};

declare function local:get-valid-distribution($tags as xs:string*) as element()*
{
  for $tag in $tags
  where contains($tag,":")
  let $key := substring-before($tag,":")
  let $keyLength := string-length($key)
  return
      if ($key="collectingevent")
      then
          let $value := substring-after(substring-after($tag,$key||":"),'=')
          return
                  element validDistribution {$value}
      else ()  
};

declare function local:get-conservation-status($tags as xs:string*) as element()*
{
  for $tag in $tags
  where contains($tag,":")
  let $key := substring-before($tag,":")
  let $keyLength := string-length($key)
  return
      if ($key="conservation")
      then
          let $value := substring-after(substring-after($tag,$key||":"),'=')
          return
                  <conservationStatus>extinct</conservationStatus>
      else ()  
};

declare function local:get-other-tags($tags as xs:string*) as element()*
{
  for $tag in $tags
  return
      if (contains($tag,":"))
      then ()
      else element tag {$tag}            
};

(: Note: had to get rid of type declaration for $machineTagLine because some records don't have it :)
declare function local:parse-tags($tagLine as xs:string, $machineTagLine) as xs:string*
{
let $tags := tokenize($tagLine," ")
let $machineTags := tokenize($machineTagLine," ")
(: Not sure why I couldn't just get distinct values of the sequence of text strings :)
let $tagElements := (
  for $tag in $tags
    return element tag {$tag},
  for $tag in $machineTags
    return element tag {$tag}
  )
return distinct-values($tagElements/text())
};

let $photos := fn:collection('chapman-raw')/photos/photo

return

(file:write("c:\test\flickr\chapman.xml",

<photos>{
      for $photo in $photos
(:      where $photo/id/text() = "5297686589" :)
(:      let $photo := $photos[6] :)
          let $uniqueTagStrings := local:parse-tags($photo/tags/text(), $photo/machineTags/text())
          let $taxonomy := local:get-taxonomy($uniqueTagStrings)
          let $revisedTaxonomy := local:getEpithets($taxonomy)
          let $geography := local:get-geography($uniqueTagStrings)
          let $validDistribution := local:get-valid-distribution($uniqueTagStrings)
          let $conservationStatus := local:get-conservation-status($uniqueTagStrings)
          let $otherTags := local:get-other-tags($uniqueTagStrings)
          return 
              <photo>
                  {$photo/id}
                  {$photo/title}
                  {$photo/license}
                  <dateTaken>{replace($photo/dateTaken/text()," ","T")}</dateTaken>
                  <tags>{
                    $otherTags
                  }</tags>
                  {$photo/format}
                  {$geography}
                  {$photo/latitude}
                  {$photo/longitude}
                  {$photo/placeId}
                  {$photo/woeid}
                  {$validDistribution}
                  {$conservationStatus}
                  {$photo/media}
                  {$photo/thumbUrl}
                  {$photo/thumbHeight}
                  {$photo/thumbWidth}
                  {$photo/originalUrl}
                  {$photo/originalHeight}
                  {$photo/originalWidth}
                  {$photo/description}
                  {$revisedTaxonomy}
              </photo>
}</photos>

))
