class Rhomb():
    def perimeter(self, side):
        return side * 4

class Square(Rhomb):
	def area(self, side):
		return side * side

mySquare = Square()
print(mySquare.perimeter(10))
print(mySquare.area(100))
