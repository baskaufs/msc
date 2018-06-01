class Rhomb():
    def __init__(self, side):
        self.perimeter = side * 4 # attribute of rhombus
        self.side = side

class Square(Rhomb):  # Square has the superclass Rhomb
	def __init__(self, side): # get the side argument
		super().__init__(side) # pass the entered side argument to the superclass init (self is assumed)
		self.area = side * side  # additional attribute defined that only applies to squares

centSquare = Square(100)
print(centSquare.side)
print(centSquare.perimeter)
print(centSquare.area)
