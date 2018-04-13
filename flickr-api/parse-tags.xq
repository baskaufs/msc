xquery version "3.1";

declare namespace functx = "http://www.functx.com";
declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? {

   concat(upper-case(substring($arg,1,1)),
             substring($arg,2))
 } ;

let $photos := fn:collection('chapman')/photos/photo
let $tags := tokenize($photos[6]/tags/text()," ")
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
            else
                element {$taxonLevel} {$taxonValue}
    else ()
}</taxonomy>