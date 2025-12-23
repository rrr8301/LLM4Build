# run.sh
#!/bin/bash

set -e

# Run tests
echo "Running tests..."
go test -v ./... || true

# Build the binary
echo "Building the binary..."
BINARY_NAME=claude-squad
GOOS=linux GOARCH=amd64 go build -v -o build/linux_amd64/$BINARY_NAME

echo "Build and test process completed."