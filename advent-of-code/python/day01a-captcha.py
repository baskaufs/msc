string = "91212129"
sum = 0

# check internal sets of two consecutive characters
for i in range(len(string)-1):
	if string[i] == string[i+1]:
		sum += int(string[i])

# check the edge case of the first and last character
if string[0] == string[len(string)-1]:
	sum += int(string[0])
	
print(sum)