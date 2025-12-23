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

# Send coverage (placeholder for COVERALLS_TOKEN)
export COVERALLS_TOKEN=your_coveralls_token_here
$GOPATH/bin/goveralls -coverprofile=coverage.out -service=github