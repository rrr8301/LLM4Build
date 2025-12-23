#!/bin/bash

set -e

# Set RUNNER_TMPDIR to a temporary directory
export RUNNER_TMPDIR=/tmp/runner

# Create the directory if it doesn't exist
mkdir -p $RUNNER_TMPDIR

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Find smithy-go
./ci-find-smithy-go.sh

# Run tests
set +e
make ci-test-no-generate
EXIT_CODE=$?

# Exit with the test result code
exit $EXIT_CODE