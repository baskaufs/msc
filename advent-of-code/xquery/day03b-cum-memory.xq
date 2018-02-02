xquery version "3.1";

(: Not finished ... :)

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



let $sequence := (1,1,2,4,5,10,11)
let $position := 7 (: indices start off one more than the Python since XQuery sequence index starts at 1 :)
let $adjacent := 1 (: indices start off one more than the Python since XQuery sequence index starts at 1 :)

(:   
for $middleNumber in (0 to 5)
:)
    let $position := $position + 1
    let $sequence := local:beginRow($position, $adjacent, $sequence)

(: 
    for $middle in (0 to $middleNumber)
        let $position := $position + 1
        let $adjacent := $adjacent + 1
        let $sequence := local:middleOfRow($position, $adjacent, $sequence)
:)   

    let $position := $position + 1
    let $adjacent := $adjacent + 1
    let $sequence := local:finishRowFlush($position, $adjacent, $sequence)
    
    let $position := $position + 1
    let $sequence := local:extendRow($position, $adjacent, $sequence)
    
    return $sequence