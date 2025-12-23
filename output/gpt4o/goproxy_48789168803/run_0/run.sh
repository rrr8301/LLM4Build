#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
set +e  # Continue executing even if some tests fail
go test -v -race -covermode atomic -coverprofile coverage.out ./...