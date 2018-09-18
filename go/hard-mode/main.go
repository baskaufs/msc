package main

import (
	"fmt"
	"io"
	"os"
)

func main() {
	fileName := os.Args[1]
	// os.Open returns a file object that has a Read method.
	// The Reader class is a receiver that requires a Read method, so that means
	// that the returned file object satisfies the condition to be a Reader type object
	// That makes it possible to use the file object directly in the io.Copy function
	file, err := os.Open(string(fileName))
	if err != nil {
		fmt.Println("Error: ", err)
		os.Exit(1)
	}

	// I guess that os.Stdout also has a Write method, meaning it implements
	// Writer interface.  That makes it possible to use it for output in
	// the io.Copy function
	io.Copy(os.Stdout, file)
}
