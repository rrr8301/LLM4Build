#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod tidy

# Run tests with coverage
go test -v -coverprofile=coverage.txt -covermode=atomic ./...

# Run go vet
go vet ./...

# Run staticcheck
staticcheck -f stylish ./...

# Check gofmt
if [ -n "$(gofmt -l .)" ]; then
  echo "Code is not formatted. Please run gofmt."
  exit 1
fi

# Check prettier
npx prettier --check **/*.{html,css,js}

# Run XO
npx xo --cwd visualization

# Ensure all tests are executed
exit 0