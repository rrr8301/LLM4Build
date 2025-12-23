#!/bin/bash

set -e

# Run go mod tidy to ensure all dependencies are fetched
go mod tidy

# Run gofmt and check for formatting issues
OUT="$(gofmt -l -d ./)"
if [ -n "$OUT" ]; then
  echo "$OUT"
  exit 1
fi

# Run golint
golint -set_exit_status ./...

# Run go vet
go vet -v ./...

# Run tests with race detection and coverage
go test -race -v -coverprofile=coverage.txt -covermode=atomic ./...