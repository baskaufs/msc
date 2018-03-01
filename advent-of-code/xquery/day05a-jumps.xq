xquery version "3.1";

declare function local:newState($sequence, $currentPosition, $count)
{
  let $jump := $sequence[$currentPosition]
  return if ($jump + $currentPosition<1)
         then let $newPosition := 0
              return $count + 1
         else if ($jump + $currentPosition>count($sequence))
              then let $newPosition := 0
                   return $count + 1
              else let $newPosition := $jump + $currentPosition
                   let $newCount := $count + 1
                   let $newSequence := ( subsequence($sequence, 1, $currentPosition - 1),$sequence[$currentPosition] + 1,subsequence($sequence, $currentPosition+1,count($sequence)) )
                   return local:newState($newSequence, $newPosition, $newCount)
};

let $string := "0
3
0
1
-3"
let $strings := tokenize($string,'\n')
let $sequence :=
    for $string in $strings
    return number($string)

return local:newState($sequence,1, 0)