import math

squareNumber = 368078

# find the number of rings to the ring inside the numbered square. Count the center square as ring 0
innerRing = int((math.sqrt(squareNumber-1)-1)/2)
outerRing = innerRing + 1 # the outer ring is the one that contains the numbered square

# calculate how far the numbered square is from the start of the ring (subtract 1 to count starting from zero)
positionOnOuterRing = squareNumber - (1+2*innerRing)**2 - 1
positionOnSide = positionOnOuterRing % (outerRing*2) # remainder of (position divided by quarter of outer ring)
distanceFromCenterOfSide = abs(positionOnSide - innerRing)
manhattanDistance = distanceFromCenterOfSide + outerRing # outerRing index is steps from center square to outerRing

print(manhattanDistance)
