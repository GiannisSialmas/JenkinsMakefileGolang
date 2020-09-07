package main

import "testing"

func TestGenerateGreeting(t *testing.T) {
	greeting := generateGreeting("Giannis")
	if greeting != "Hello Giannis" {
		t.Errorf("Generated greeting was incorrect, got: %s, want: \"Hello Giannis\".", greeting)
	}
}
