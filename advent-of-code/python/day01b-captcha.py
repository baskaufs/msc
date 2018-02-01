string = "12131415"
sum = 0
step = int(len(string)/2)

# check sets of characters separated by step
for i in range(step):
	if string[i] == string[i+step]:
		sum += int(string[i])
	
print(sum*2)