package main

import (
	"fmt"
)

type bot interface {
	getGreeting() string
}

type englishBot struct{}
type spanishBot struct{}

func main() {
	eb := englishBot{}
	sb := spanishBot{}

	printGreeting(eb)
	printGreeting1(sb)

}

func (eb englishBot) getGreeting() string {
	// custom logic
	return "Hi there"
}

func (sb spanishBot) getGreeting() string {
	// custom logic
	return "|Hola chicos!"
}

func printGreeting(b bot) {
	fmt.Println(b.getGreeting())
}
