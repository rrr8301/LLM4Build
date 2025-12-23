#!/bin/bash
set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Check go.mod file
GO_VERSION=$(go mod edit -json | jq -r .Go)
if ! [[ $GO_VERSION =~ ^[0-9]+\.[0-9]+$ ]]; then
  echo "^^^^ Incorrect go directive in go.mod: use only 'minor.major'."
  exit 1
fi

# Build the project
make && ./bin/akvorado version

# Run tests
make test  # Ensure all tests run