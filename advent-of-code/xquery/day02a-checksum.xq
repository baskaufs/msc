xquery version "3.1";

declare function local:turn-xmldoc-to-ranges($xmlChecksum as document-node() ) as xs:double+
{
  for $line in $xmlChecksum/csv/record/entry/text()
  return local:range-of-num-seq($line)
};

declare function local:range-of-num-seq($line as xs:string) as xs:double
{
  let $num-seq := local:turn-string-into-number-sequence($line)
  return (max($num-seq)-min($num-seq))
};

declare function local:turn-string-into-number-sequence($string as xs:string) as xs:double+ 
{
  let $string-sequence := tokenize($string,'&#9;')  (: &#9; is the tab character :)
  for $string in $string-sequence
  return number($string)
};

let $checksumDoc := file:read-text('file:///c:/Dropbox/aoc.csv')
let $xmlChecksum := csv:parse($checksumDoc, map { 'header' : false() })
let $rangeSequence := local:turn-xmldoc-to-ranges($xmlChecksum)
return sum($rangeSequence)