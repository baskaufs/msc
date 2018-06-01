# this program uses an object to return multiple attributes from a function
class Duck():
    def __init__(self):
        # instantiate the Duck object with default values
        self.name = "default name"
        self.company = "a generic company"
        self.nemesis = "an unknown enemy"

def create_duck(name, company, nemesis):
    # create a generic Duck instance	
    myDuck = Duck()
    if name:  # empty strings are considered boolean false, so passed empty strings will prevent overwriting default attributes
        myDuck.name = name
    if company:
        myDuck.company = company
    if nemesis:
        myDuck.nemesis = nemesis
    return myDuck

# in main routine, create a list of ducks
duck = list()
duck.append(create_duck("Donald", "Disney", "Mickey Mouse"))
duck.append(create_duck("Daffy", "Warner Brothers", "Elmer Fudd"))
duck.append(create_duck("Howard", "", "Wile E. Coyote"))

for index in range(0,len(duck)): # len() function returns number of items, so for the zero-based index, the len() provides the last-index+1 as needed for the loop to funciton correctly
    print('My name is ' + duck[index].name + ' Duck. I work for ' + duck[index].company + '. My nemesis is ' + duck[index].nemesis +'.')