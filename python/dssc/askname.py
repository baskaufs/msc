fileObject = open("dssc.txt", newline='')
nameList = fileObject.readlines()

# nameList = ["Andy", "Steve", "Stacy"]
for name in nameList:
    #name = item.strip()
    if name=="Steve":
        print(name, ", you are a Baskauf")
        print("the value of pi is 3.14")
    else:
        print(name, ", you are a Wesolek")