xquery version "3.1";

declare function local:firstPosition($side as xs:integer, $position as xs:double, $adjacent as xs:double, $oldSequence as xs:integer*)
{

if ($side = 0)
    then 
        let $sum := $oldSequence[$position - 1] + $oldSequence[$position - 2] + $oldSequence[$adjacent] + $oldSequence[$adjacent + 1]
        let $newSequence := insert-before($oldSequence, count($oldSequence) + 1, $sum )
        return $newSequence

    else ()

};

declare function local:beginRow($position, $adjacent, $oldSequence as xs:integer*)
{
  let $sum := $oldSequence[$position - 1] + $oldSequence[$position - 2] + $oldSequence[$adjacent] + $oldSequence[$adjacent + 1]
  let $newSequence := insert-before($oldSequence, count($oldSequence) + 1, $sum )
  return ($newSequence)
};

declare function local:middleOfRow($position, $adjacent, $oldSequence as xs:integer*)
{
  let $sum := $oldSequence[$position - 1] + $oldSequence[$adjacent - 1] + $oldSequence[$adjacent] + $oldSequence[$adjacent + 1]
  let $newSequence := insert-before($oldSequence, count($oldSequence) + 1, $sum )
  return ($newSequence)
};

declare function local:finishRowFlush($position, $adjacent, $oldSequence as xs:integer*)
{
  let $sum := $oldSequence[$position - 1] + $oldSequence[$adjacent - 1] + $oldSequence[$adjacent]
  let $newSequence := insert-before($oldSequence, count($oldSequence) + 1, $sum )
  return ($newSequence)
};

declare function local:extendRow($position, $adjacent, $oldSequence as xs:integer*)
{
  let $sum := $oldSequence[$position - 1] + $oldSequence[$adjacent]
  let $newSequence := insert-before($oldSequence, count($oldSequence) + 1, $sum )
  return ($newSequence)
};


(: Note: the algorithm I'm using would require purpose-build functions for ring = 0, and I don't want to bother with that.  So I'm just starting the sequence off with positions 1 through 9 calculated manually. :)
let $sequence := (1,1,2,4,5,10,11,23,25)
(: Note: the position index numbering starts with 1 since XQuery sequence indices starts at 1. This differs from Python where list index numbering starts with 0 :)
  
for $ring in (1 to 5)  (: This is a bit sloppy since it requires trial and error to decide on the upper limit (i.e.5) :)
    let $adjacencyBaseForRing :=  math:pow(2 * $ring + 1, 2)
    let $sideLength := 2 * ($ring + 1)
    for $side in (0 to 3)
        let $adjacencyBaseForSide := $adjacencyBaseForRing + $side * $ring * 2
        let $positionBaseForSide := $adjacencyBaseForSide + 1 + $sideLength * $side
        (: first position on side :)
        let $sequence := local:firstPosition($side, $positionBaseForSide, $adjacencyBaseForSide, $sequence)
        return $sequence

