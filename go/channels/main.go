package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	sites := []string{
		"http://google.com",
		"http://facebook.com",
		"http://stackoverflow.com",
		"http://golang.org",
		"http://amazon.com",
	}

	ch := make(chan string)

	for _, site := range sites {
		go httpRequest(site, ch)
	}

	/* check the link again each time there is a response from the channel from that website test
	for {
		go httpRequest(<-ch, ch)
	}
	*/

	// The range of the channel ch is infinite - the loop executes each time there is a new channel response
	for link := range ch {
		// This initiates an anonymous function (similar to lambda in Python).  The anon. func in {} replaces the function name.
		go func(staticLink string) {
			time.Sleep(5 * time.Second)
			httpRequest(staticLink, ch)
			// the link gets passed by value so that its value doesn't get messed up by the called channel
		}(link)
	}

}

func httpRequest(link string, ch chan string) {
	_, err := http.Get(link)
	if err != nil {
		fmt.Println(link, "is down")
		ch <- link
		return
	}

	fmt.Println(link, "is up")
	ch <- link
}
