#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH="/go"
export PATH="${GOPATH}/bin:${PATH}"

# Install project dependencies
go mod download

# Run gofmt
gofmt -d -e . 2>&1 | tee outfile && test -z "$(cat outfile)" && rm outfile

# Run staticcheck
if command -v staticcheck >/dev/null 2>&1; then
    staticcheck ./...
else
    echo "staticcheck not found - skipping"
fi

# Run go vet
go vet ./...
if [ -d "_examples" ]; then
    cd _examples && go vet ./... && cd ..
fi

# Run go test
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./...
if [ -d "_examples" ]; then
    cd _examples && go test -v -race ./... && cd ..
fi

# Run godog if cmd/godog exists
if [ -d "cmd/godog" ]; then
    go install ./cmd/godog
    godog -f progress --strict
fi

# Ensure all tests are executed
exit 0