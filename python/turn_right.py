import turtle

def drawSquare(myTurtle,maxSide):
    for sideLength in range(1,maxSide+1):
        myTurtle.forward(100)
        myTurtle.right(170)

t = turtle.Turtle()
drawSquare(t,100)

			