#!/bin/bash

# Run gofmt and fail if there are any formatting issues
gofmt -d -e . 2>&1 | tee outfile && test -z "$(cat outfile)" && rm outfile

# Run go vet
go vet ./...

# Check if _examples directory exists before running tests
if [ -d "_examples" ]; then
    cd _examples && go vet ./... && cd ..
fi

# Run go test
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./...

# Check if _examples directory exists before running tests
if [ -d "_examples" ]; then
    cd _examples && go test -v -race ./... && cd ..
fi

# Run godog
godog -f progress --strict