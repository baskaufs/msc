xquery version "3.1";

(: Note: I had to run this at the command line, with additional allocated memory because I ran out of main memory via the BaseX GUI :)

declare namespace functx = "http://www.functx.com";
declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? {

   concat(upper-case(substring($arg,1,1)),
             substring($arg,2))
 } ;

declare function local:get-taxonomy($tagLine as xs:string) as element()
{
let $tags := tokenize($tagLine," ")
return <taxonomy>{
        for $tag in $tags
        return
            if (substring($tag,1,9)="taxonomy:")
            then
                let $taxonLevel := substring-before(substring-after($tag,"taxonomy:"),'=')
                let $taxonValue := substring-after(substring-after($tag,"taxonomy:"),'=')
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

declare function local:get-geography($tagLine as xs:string) as element()*
{
let $tags := tokenize($tagLine," ")
return 
        for $tag in $tags
        return
            if (substring($tag,1,4)="geo:")
            then
                let $geoTag := substring-before(substring-after($tag,"geo:"),'=')
                let $geoValue := substring-after(substring-after($tag,"geo:"),'=')
                return
                        element {$geoTag} {$geoValue}
            else if (substring($tag,1,8)="geocode:")
            then
                let $geoTag := substring-before(substring-after($tag,"geocode:"),'=')
                let $geoValue := substring-after(substring-after($tag,"geocode:"),'=')
                return
                        element {$geoTag} {$geoValue}            
            else ()  
};

declare function local:get-other-tags($tagLine as xs:string) as element()*
{
let $tags := tokenize($tagLine," ")
return 
        for $tag in $tags
        return
            if (contains($tag,":"))
            then ()
            else element tag {$tag}            
};

let $photos := fn:collection('chapman-raw')/photos/photo
return(file:write("c:\test\flickr\chapman.xml",

<photos>{
      for $photo in $photos
          let $taxonomy := local:get-taxonomy($photo/tags/text())
          let $revisedTaxonomy := local:getEpithets($taxonomy)
          let $geography := local:get-geography($photo/tags/text())
          let $otherTags := local:get-other-tags($photo/tags/text())
          return 
              <photo>
                  {$photo/id}
                  {$photo/title}
                  {$photo/license}
                  <dateTaken>{replace($photo/dateTaken/text()," ","T")}</dateTaken>
                  <tags>{
                    $otherTags
                  }</tags>
                  {$photo/machineTags}
                  {$photo/format}
                  {$geography}
                  {$photo/latitude}
                  {$photo/longitude}
                  <gpsAccuracy>{$photo/accuracy/text()}</gpsAccuracy>
                  {$photo/placeId}
                  {$photo/woeid}
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
