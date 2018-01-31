xquery version "3.1";

declare namespace functx = "http://www.functx.com";
declare function functx:chars
  ( $arg as xs:string? )  as xs:string* {

   for $ch in string-to-codepoints($arg)
   return codepoints-to-string($ch)
 } ;
 
declare function local:matchTest($string as xs:string) as xs:double*
{
let $step := string-length($string) div 2
let $sequence := functx:chars($string)
for sliding window $w in $sequence
  start at $s when fn:true()
  only end at $e when $e - $s eq $step
  return if ($w[1] = $w[last()])
  then fn:number($w[1])
  else ()
};

let $string := "12131415" 

return 2*sum(local:matchTest($string))