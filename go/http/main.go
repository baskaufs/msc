package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

type logWriter struct{}

func main() {
	resp, err := http.Get("http://google.com")
	if err != nil {
		fmt.Println("Error: ", err)
		os.Exit(1)
	}
	//byteSlice := make([]byte, 99999) //slice has 99999 empty spots
	// Note: read function isn't set up to resize the byteSlice, so use an arbitrarily large slice
	//resp.Body.Read(byteSlice)
	//fmt.Println(string(byteSlice))

	lw := logWriter{}

	io.Copy(lw, resp.Body)
}

func (logWriter) Write(bs []byte) (int, error) {
	fmt.Println(string(bs))
	fmt.Println("Just wrote", len(bs), "bytes.")

	return len(bs), nil
}
