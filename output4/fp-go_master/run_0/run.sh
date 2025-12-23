#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod tidy

# Run tests
set +e  # Continue execution even if some tests fail
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./...