package main

import (
	"fmt"
)

type shape interface {
	calcArea() float64
}

type triangle struct {
	base   float64
	height float64
}
type square struct {
	sideLength float64
}

func main() {
	tr := triangle{base: 10, height: 10}
	sq := square{sideLength: 10}

	printArea(tr)
	printArea(sq)

}

func (tr triangle) calcArea() float64 {
	return 0.5 * tr.base * tr.height
}

func (sq square) calcArea() float64 {
	return sq.sideLength * sq.sideLength
}

func printArea(s shape) {
	fmt.Println(s.calcArea())
}
