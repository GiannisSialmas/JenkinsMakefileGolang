compile-platforms: install-deps test
    # 64-Bit
    # FreeBDS
	GOOS=freebsd GOARCH=amd64 go build -o bin/main-freebsd-amd64 src/main.go
	tar --remove-files -czvf bin/main-freebsd-amd64.tar.gz bin/main-freebsd-amd64
    # MacOS
	GOOS=darwin GOARCH=amd64 go build -o bin/main-darwin-amd64 src/main.go
	tar --remove-files -czvf bin/main-darwin-amd64.tar.gz bin/main-darwin-amd64
    # Linux
	GOOS=linux GOARCH=amd64 go build -o bin/main-linux-amd64 src/main.go
	tar --remove-files -czvf bin/main-linux-amd64.tar.gz bin/main-linux-amd64
    # Winodws
	GOOS=windows GOARCH=amd64 go build -o bin/main-windows-amd64 src/main.go
	tar --remove-files -czvf bin/main-windows-amd64.tar.gz bin/main-windows-amd64

compile: install-deps test
	go build -o bin/main src/main.go

test: install-deps
	go test ./src

install-deps: 
	go mod download

run:
	go run src/main.go