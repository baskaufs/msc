xquery version "3.1";

(: for comments on method, see day3a-manhattan.py :)

let $squareNumber := 368078
let $innerRing := floor((math:sqrt($squareNumber - 1) - 1) div 2)
let $outerRing := $innerRing + 1
let $positionOnOuterRing := $squareNumber - math:pow(1 + 2 * $innerRing, 2) - 1
let $positionOnSide := $positionOnOuterRing mod ($outerRing * 2)
let $distanceFromCenterOfSide := abs($positionOnSide - $innerRing)
let $manhattanDistance := $distanceFromCenterOfSide + $outerRing

return $manhattanDistance