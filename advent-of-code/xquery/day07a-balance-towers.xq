xquery version "3.1";

(: parse the puzzle input into edges represented by subject nodes (progName) and object nodes (progAbove), if any.
Use XML to maintain the structure. :)
declare function local:make-graph-xml($puzzle as xs:string) as element()
{
let $lines := tokenize($puzzle,"\n")
return <root>{
for $phrase in $lines
    let $progName := substring-before($phrase," ")
    let $weight := substring-before(substring-after($phrase,"("),")")
    let $progsAboveString := substring-after($phrase,"> ")
    let $progsAboveSeqWhite := tokenize($progsAboveString,",") (: split stacked programs by commas :)
    let $progsAboveSeq := 
        (: need to trim off leading space :)
        for $progs in $progsAboveSeqWhite
        return normalize-space($progs)
    return 
        if (string-length($progsAboveString)=0)
        then 
                <prog>
                    <progName>{$progName}</progName>
                    <weight>{$weight}</weight>
                    <progAbove/>
                </prog>
        else
            for $prog in $progsAboveSeq
            return
                <prog>
                    <progName>{$progName}</progName>
                    <weight>{$weight}</weight>
                    <progAbove>{$prog}</progAbove>
                </prog>
}</root>
};

(: recursive function to strip off layers of edges, starting from the top going down. :)
declare function local:return-lower($progs as element()+,$previousTry as xs:string) as xs:string
{
  let $lower := 
          for $prog in $progs
              let $test :=
                      (: check each edge to see if the subject is the object of any other edge :)
                      for $above in $progs
                      return
                            (: each time one is found, a boolean TRUE is added to the sequence :)
                            if ($prog/progAbove/text()=$above/progName/text())
                            then true()
                            else ()
              return
                  (: count the number of TRUE values in the test sequence.  
                  If there aren't any, then the object of the edge isn't the subject of any other edge.
                  That means it is at the highest level of the remaining edges and should be eliminated.  :)
                  if (count($test) = 0)
                  then ()
                  else $prog  (: If there are higher nodes, then keep the edge in the set of edges :)
  let $answer :=
         (: if there aren't any lower edges, then report the subject of the first of the previous set of lowest edges :)
         if (count($lower)=0)
         then $previousTry
         else local:return-lower($lower,$lower[1]/progName/text()) (: use recursion to remove another layer of edges :)
  return $answer   
};

let $puzzle := "pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)"

let $graph := local:make-graph-xml($puzzle)
(: The "edges" that don't have any objects are really just terminal nodes, so get rid of them. :)
let $nonTerminalEdges :=
    for $edge in $graph/prog
    return if (exists($edge/progAbove/text()))
    then $edge
    else ()

(: send the non-terminal edges to the recursive function that strips away the layers from the top down. :)
let $lowestEdges := local:return-lower($nonTerminalEdges,"previousTry")
return $lowestEdges