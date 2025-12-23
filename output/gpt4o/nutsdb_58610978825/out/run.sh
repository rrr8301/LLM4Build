#!/bin/bash

# Clean test directories
rm -rf /tmp/nutsdb* || true
rm -rf /tmp/test-hintfile* || true

# Build the project
go build -v ./...

# Run unit tests with timeout and retries
for i in {1..3}; do
  echo "Test attempt $i/3"
  if timeout 20m go test -v -race -timeout 15m ./...; then
    echo "Tests passed on attempt $i"
    break
  elif [ $i -eq 3 ]; then
    echo "Tests failed after 3 attempts"
    exit 1
  else
    echo "Tests failed on attempt $i, retrying..."
    sleep 5
    # Clean any remaining test files
    rm -rf /tmp/nutsdb* || true
    rm -rf /tmp/test-hintfile* || true
  fi
done