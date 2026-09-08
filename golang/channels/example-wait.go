package main

import "fmt"

func main() {
	// Initializing channel (make is required!)
	c := make(chan string)

	// Sending blocks until someone reads
	go func() {
		c <- "hello" // Blocks, waits for a receiver
	}()

	// Getting the data from channel
	value := <-c // Receives "hello"
	fmt.Println(value)
}
