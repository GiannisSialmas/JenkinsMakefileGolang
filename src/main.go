package main

import "fmt"

func main() {
	greeting := generateGreeting("Giannis")
	fmt.Println(greeting)
}

func generateGreeting(name string) string {
	password := fmt.Sprintf("password=%s", name)
	fmt.Println(password)
	greeting := fmt.Sprintf("Hello %s", name)
	return greeting
}
