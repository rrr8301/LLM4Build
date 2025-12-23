#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod tidy

# Run tests with correct covermode flag
set +e
go test -v -coverprofile="coverage.txt" -covermode=atomic ./...
set -e

# Upload to Codecov
echo "Uploading coverage to Codecov..."
curl -s https://codecov.io/bash | bash -s -- -R goplus/xgo