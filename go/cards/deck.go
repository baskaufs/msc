package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

// Creating a deck type that's a slice of strings
type deck []string

func newDeck() deck {
	cards := deck{}
	cardSuits := []string{"spades", "clubs", "hearts", "diamonds"}
	cardValues := []string{"ace", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "jack", "queen", "king"}

	for _, suit := range cardSuits {
		for _, value := range cardValues {
			cards = append(cards, value+" of "+suit)
		}
	}

	return cards
}

func (d deck) print() {
	for i, card := range d {
		fmt.Println(i, card)
	}
}

func deal(d deck, numCards int) (deck, deck) {
	return d[:numCards], d[numCards:]
}

func (d deck) toString() string {
	// the deck gets turned into a slice of strings, then the strings are joined by comma characters
	return strings.Join([]string(d), ",")
}

func (d deck) saveDeck(fileName string) error {
	byteSlice := []byte(d.toString())
	return ioutil.WriteFile(fileName, byteSlice, 0666)
}
