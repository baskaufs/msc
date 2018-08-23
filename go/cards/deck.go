package main

import "fmt"

// Creating a deck type that's a slice of strings
type deck []string

func newDeck() {

}

func (d deck) print() {
	for i, card := range d {
		fmt.Println(i, card)
	}

}
