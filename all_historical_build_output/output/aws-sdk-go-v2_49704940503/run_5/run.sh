#!/bin/bash

set -e

# Set RUNNER_TMPDIR to a temporary directory
export RUNNER_TMPDIR=/tmp/runner

# Create the directory if it doesn't exist
mkdir -p $RUNNER_TMPDIR

# Activate Go environment
export PATH="/usr/local/go/bin:/root/go/bin:${PATH}"

# Ensure the correct Go version is used
go version

# Set the correct Go version environment variable
export GO_VERSION=1.21.1

# Find smithy-go
./ci-find-smithy-go.sh

# Run tests
set +e
make ci-test-no-generate
EXIT_CODE=$?

# Exit with the test result code
exit $EXIT_CODE