#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# Example: source /path/to/venv/bin/activate

# Install project dependencies (if any)
# Example: go mod download

# Run tests
go test -v ./... || true

# Build the project
BINARY_NAME=claude-squad
go build -v -o build/linux_amd64/$BINARY_NAME

# Ensure all test cases are executed, even if some fail
# The `|| true` ensures that the script continues even if tests fail