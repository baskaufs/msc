package main

import "fmt"
import "math"

func main() {
	numList := []int{}
	for index := 0; index <= 10; index++ {
		numList = append(numList, index)
	}
	for _, numItem := range numList {
		if math.Mod(float64(numItem), 2.0) == 0 {
			fmt.Print(numItem, " is even", "\n")
		} else {
			fmt.Print(numItem, " is odd", "\n")
		}
	}
	// fmt.Println(numList)
}
