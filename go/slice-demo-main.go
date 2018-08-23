package something

import "fmt"

func main() {
	// var card string = "Ace of Spades"
	// card := "Ace of Spades" // colon causes type to be assigned on first use

	// a "slice" does not have a fixed length and can be added to
	cards := []string{"Ace of Diamonds", newCard()}
	cards = append(cards, "Six of Spades")

	for i, card := range cards {
		fmt.Println(i, card)
	}
}

func newCard() string {
	return "Five of Diamonds"
}
