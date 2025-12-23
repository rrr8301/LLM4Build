#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH="/go"
export PATH="$GOPATH/bin:${PATH}"

# Install project dependencies
go mod tidy

# Run tests with correct covermode flag
set +e
go test -v -coverprofile="coverage.txt" -covermode=atomic ./...
test_exit_code=$?
set -e

# Upload to Codecov if tests passed
if [ $test_exit_code -eq 0 ]; then
    echo "Uploading coverage to Codecov..."
    curl -s https://codecov.io/bash | bash -s -- -R goplus/xgo
else
    echo "Tests failed, skipping Codecov upload"
fi

exit $test_exit_code