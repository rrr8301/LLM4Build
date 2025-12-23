#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run gofmt and fail if there are any formatting issues
gofmt -d -e . 2>&1 | tee outfile && test -z "$(cat outfile)" && rm outfile

# Run go vet
go vet ./...
cd _examples && go vet ./... && cd ..

# Run go test
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./...
cd _examples && go test -v -race ./... && cd ..

# Run godog
godog -f progress --strict