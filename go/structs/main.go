package main

import (
	"fmt"
)

type contactInfo struct {
	email   string
	zipCode int
}

type person struct {
	firstName string
	lastName  string
	contact   contactInfo
}

func main() {
	fred := person{
		firstName: "Frederick",
		lastName:  "Douglas",
		contact: contactInfo{
			email:   "fred@douglas.org",
			zipCode: 37212,
		},
	}
	fredPointer := &fred // The ampersand refers to address pointed to by the variable fred
	//fredPointer.updateName("Freddy") // this is how it should be written
	fred.updateName("Freddy") // Go allows the object to be used instead of its pointer as long as there is an asterisk in the type in the function definition

	fred.print()
}

func (pointerToPerson *person) updateName(newFirstName string) { // here the asterisk means we are working with a pointer to a person
	(*pointerToPerson).firstName = newFirstName // The asterisk here refers to the value at address pointed to by pointer
}

func (p person) print() {
	fmt.Printf("%+v", p)
}
