xquery version "3.1";

declare function local:redistribute($sequence, $stringSequence, $count)
{
let $stacks := count($sequence)
let $max := max($sequence)
let $position := index-of($sequence,$max)[1]  (: if there are more than one maximum value, use the lowest numbered one in the sequence :)
let $baseAdd := floor($max div $stacks)
let $extra := $max mod $stacks

(: create a new sequence that has eliminated the largest stack :)
let $dropSequence := ( subsequence($sequence, 1, $position - 1),0,subsequence($sequence, $position+1) )

(: create a new sequence that redistributes the blocks that will come out evenly amon the stackes :)
let $baseAddSequence :=
    for $item in $dropSequence
    return $item + $baseAdd

(: distribute the extra blocks that won't come out evenly :)
let $extraAddSequence :=
    let $more := $extra - ($stacks - $position)
    return
        if ($extra > ($stacks - $position))
        then
          (: case where remaining blocks wrap past end :)
          (
          let $more := $extra - ($stacks - $position)
          for $item in subsequence($baseAddSequence, 1, $more ) 
          return $item + 1,
          subsequence($baseAddSequence, $more + 1, $position - $more),
          for $item in subsequence($baseAddSequence, $position + 1)
          return $item + 1
          )
        else
          (: case where remaining blockes don't wrap past end :)
          (
          subsequence($baseAddSequence, 1, $position),
          for $item in subsequence($baseAddSequence, $position + 1, $extra) 
          return $item + 1,
          subsequence($baseAddSequence, $position + $extra + 1)
          )
let $sequenceString := string-join($extraAddSequence," ")
let $newStringSequence := ($stringSequence, $sequenceString)
let $answer := 
    if (count(distinct-values($newStringSequence)) = count($newStringSequence))
    then local:redistribute($extraAddSequence, $newStringSequence, $count + 1)
    else $count + 1 - index-of($stringSequence, $sequenceString)   
return $answer
};

let $string := "11	11	13	7	0	15	5	5	4	4	1	1	7	1	15	11"

let $strings := tokenize($string,'	')
let $sequence :=
    for $string in $strings
    return number($string)
let $count := 0
let $stringSequence := ()
   
return local:redistribute($sequence, $stringSequence, $count)
