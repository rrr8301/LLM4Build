#!/bin/bash

set -e

# Activate Go environment
export GOPATH=/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Install project dependencies
go get -d -t ./...

# Run tests
set +e
make test
TEST_EXIT_CODE=$?

# Exit with the test exit code
exit $TEST_EXIT_CODE