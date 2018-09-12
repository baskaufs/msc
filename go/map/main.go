package main

import (
	"fmt"
)

func main() {
	// var color map[string]string

	// color := make(map[string]string)

	// color["red"] = "#ffff"
	// color["blue"] = "#f000"
	// delete(color, "red")

	color := map[string]string{
		"red":   "#ff000",
		"green": "#4bf745",
		"white": "#ffffff",
	}
	printMap(color)
}

func printMap(c map[string]string) {
	for color, hex := range c {
		fmt.Println(color, hex)
	}
}
