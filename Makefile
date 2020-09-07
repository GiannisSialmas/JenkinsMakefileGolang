build:
	go build -o bin/main src/main.go

test:
	go test ./src

run:
	go run src/main.go

compile:
    # 64-Bit
    # FreeBDS
	GOOS=freebsd GOARCH=amd64 go build -o bin/main-freebsd-amd64 src/main.go
    # MacOS
	GOOS=darwin GOARCH=amd64 go build -o bin/main-darwin-amd64 src/main.go
    # Linux
	GOOS=linux GOARCH=amd64 go build -o bin/main-linux-amd64 src/main.go
    # Winodws
	GOOS=windows GOARCH=amd64 go build -o bin/main-windows-amd64 src/main.go