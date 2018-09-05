package main

import (
	"os"
	"testing"
)

func TestNewDeck(t *testing.T) {
	d := newDeck()
	if len(d) != 52 {
		t.Errorf("Expected deck length of 52, but got %v", len(d))
	}

	if d[0] != "ace of spades" {
		t.Errorf("First card was supposed to be ace of spades, but was %v", d[0])
	}

	if d[len(d)-1] != "king of diamonds" {
		t.Errorf("Last card was supposed to be king of diamonds, but was %v", d[len(d)-1])
	}

}

func TestSaveDeckAndLoadDeck(t *testing.T) {
	os.Remove("_decktesting")

	d := newDeck()
	d.saveDeck("_decktesting")

	loadedDeck := loadDeck("_decktesting")

	if len(loadedDeck) != 52 {
		t.Errorf("Expected 52 cards, but got %v", len(loadedDeck))
	}

	os.Remove("_decktesting")
}
