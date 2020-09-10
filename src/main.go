package main

import (
	"fmt"

	log "github.com/sirupsen/logrus"
)

func main() {
	log.Info("Program Starting")
	greeting := generateGreeting("Giannis")
	log.Info(greeting)
}

func generateGreeting(name string) string {
	greeting := fmt.Sprintf("Hello %s", name)
	return greeting
}

// This exists to trigger a warning when doing static code analysis
func doNothing() {
}
