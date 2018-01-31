xquery version "3.1";

declare namespace functx = "http://www.functx.com";
declare function functx:chars
  ( $arg as xs:string? )  as xs:string* {

   for $ch in string-to-codepoints($arg)
   return codepoints-to-string($ch)
 } ;
 
declare function local:matchTest($string xs:string) as xs:double*
{
let $sequence := functx:chars($string)
for sliding window $w in $sequence
  start at $s when fn:true()
  only end at $e when $e - $s eq 1
  return if ($w[1] = $w[2])
  then fn:number($w[1])
  else ()
};

declare function local:edgeCase($string as xs:string) as xs:double?
{
let $sequence := functx:chars($string)
return if ($sequence[1] = $sequence[last()])
then fn:number($sequence[1])
else ()
};

let $string := "91212129" 

return sum( (local:matchTest($string),local:edgeCase($string)) )