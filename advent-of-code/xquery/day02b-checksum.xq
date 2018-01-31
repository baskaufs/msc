xquery version "3.1";

declare function local:turn-xmldoc-to-divisions($xmlChecksum as document-node() ) as xs:double+
{
  for $line in $xmlChecksum/csv/record/entry/text()
  return local:division-of-num-seq($line)
};

declare function local:division-of-num-seq($line as xs:string) as xs:double
{
  let $num-seq := local:turn-string-into-number-sequence($line)
  for $item in $num-seq
    return local:find-if-number-is-numerator($item,$num-seq)
};

declare function local:turn-string-into-number-sequence($string as xs:string) as xs:double+ 
{
  let $string-sequence := tokenize($string,'&#9;')  (: &#9; is the tab character :)
  for $string in $string-sequence
  return number($string)
};

declare function local:find-if-number-is-numerator($number as xs:double, $sequence as xs:double+) as xs:double?
{
  for $item in $sequence
  return if ($number mod $item = 0)
        then if ($number div $item != 1)
             then $number div $item
             else ()
        else ()
};

let $checksumDoc := file:read-text('file:///c:/Dropbox/aoc.csv')
let $xmlChecksum := csv:parse($checksumDoc, map { 'header' : false() })
let $divSequence := local:turn-xmldoc-to-divisions($xmlChecksum)

return sum($divSequence)