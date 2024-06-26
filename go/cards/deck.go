package main

import (
	"fmt"
	"io/ioutil"
	"math/rand"
	"os"
	"strings"
	"time"
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

func loadDeck(fileName string) deck {
	byteSlice, err := ioutil.ReadFile(fileName)
	if err != nil {
		// list error and quit
		fmt.Println("Error: ", err)
		os.Exit(1)
	}
	s := strings.Split(string(byteSlice), ",")
	return deck(s)
}

func (d deck) shuffle() {
	for i := range d {
		source := rand.NewSource(time.Now().UnixNano())
		r := rand.New(source)
		newPosition := r.Intn(len(d) - 1)
		d[i], d[newPosition] = d[newPosition], d[i]

	}
}
