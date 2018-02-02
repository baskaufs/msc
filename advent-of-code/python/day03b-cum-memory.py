def beginRow(position,array):
	position[0] += 1 # increment position index
	# the adjacent position does not change because a corner was just turned
	position[1] = array[position[0]-1] + array[position[0]-2] + array[position[2]] + array[position[2]+1] # add the previous 2 positions, the adjacent position, and the next adjacent position
	return (position)

def middleOfRow(position,array):
	position[0] += 1 # increment position index
	position[2] += 1 # increment adjacent index
	position[1] = array[position[0]-1] + array[position[2]-1] + array[position[2]] + array[position[2]+1] # add the previous position, the adjacent position, and adjacent position before and after
	return (position)

def finishRowFlush(position,array):
	position[0] += 1 # increment position index
	position[2] += 1 # increment adjacent index
	position[1] = array[position[0]-1] + array[position[2]-1] + array[position[2]] # add the previous position, the adjacent position, and the previous adjacent position
	return (position)

def extendRow(position,array):
	position[0] += 1 # increment position index
	position[1] = array[position[0]-1] + array[position[2]] # add the previous position and the unchanged adjacent position
	# the adjacent position does not change because the corner will be turned
	return (position)
	


array = [1,1,2,4,5,10,11] # create a new list variable to hold the set of calculated position sum values
position = [6,0,0] # create a new list variable for info about the position
# 0th element is the index of the current position (starting at the central square). It's zero because in Python, list indexing begins with 0. 
# 1st element is the sum for the current position.
# 2nd element is the index of the adjacent position (beside the current position towards the center). Meaningless for the first square


for i in range(len(array)):
	print(array[i])
	
# at this point the spiral extension pattern begins with two sides having the same number of middle row spaces
# then the number of middle row spaces increments and repeats twice again...
for middleNumber in range(6):
	print("middleNumber "+str(middleNumber))
	for duplicate in range(2):
		print("duplicate "+str(duplicate))
		position = beginRow(position,array)
		print("begin "+str(position[1]))
		array.append(position[1])
		for middle in range(middleNumber):
			print("middle "+str(middle))
			position = middleOfRow(position,array)
			print(position[1])
			array.append(position[1])
		position = finishRowFlush(position,array)
		print("finish "+str(position[1]))
		array.append(position[1])
		position = extendRow(position,array)
		print("extend "+str(position[1]))
		array.append(position[1])



