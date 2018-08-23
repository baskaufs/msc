package main

import "fmt"

type book string

func (b book) printTitle() {
	fmt.Println(b)
}

func main() {
	var b book = "Harry Potter"
	b.printTitle()
}
