
declare function local:parse-tags($tagLine, $machineTagLine)
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
return $tagElements
};


let $photos := fn:collection('chapman-raw')/photos/photo
let $tags :=
    for $photo in $photos
        let $uniqueTagStrings := local:parse-tags($photo/tags/text(), $photo/machineTags/text())
        return $uniqueTagStrings
let $uniqueTags := distinct-values(
    for $tag in $tags/text()
    where contains($tag,":")
    return $tag
  )
    
for $tag in $uniqueTags
order by $tag
return $tag
