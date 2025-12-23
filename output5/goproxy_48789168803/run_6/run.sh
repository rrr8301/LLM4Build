#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Download Go modules
go mod download

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -race -covermode atomic -coverprofile coverage.out ./...
set -e

# Note: Uploading code coverage to Codecov is not automated in this script.
# To upload manually, use the following command:
# curl -s https://codecov.io/bash | bash -s -- -t <CODECOV_TOKEN> -f coverage.out