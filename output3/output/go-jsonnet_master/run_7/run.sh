#!/bin/bash

# Activate environments if needed (e.g., virtualenv, conda)
# Placeholder for environment activation

# Ensure Go version in go.mod is correct
sed -i 's/^go [0-9]*\.[0-9]*\.[0-9]*/go 1.23/' go.mod

# Install project dependencies
make install.dependencies

# Run tests
make test  # Ensure all tests run

# Run all build steps
make all

# Check if COVERALLS_TOKEN is set
if [ -z "$COVERALLS_TOKEN" ]; then
  echo "COVERALLS_TOKEN is not set. Please set it to send coverage data."
  exit 1
fi

# Send coverage
$GOPATH/bin/goveralls -coverprofile=coverage.out -service=github