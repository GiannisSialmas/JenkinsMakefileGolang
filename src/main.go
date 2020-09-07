package main

import "fmt"

func main() {
	greeting := generateGreeting("Giannis")
	fmt.Println(greeting)
}

func generateGreeting(name string) string {
	greeting := fmt.Sprintf("Hello %s", name)
	return greeting
}
