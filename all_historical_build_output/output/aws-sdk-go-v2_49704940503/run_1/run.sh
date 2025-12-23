#!/bin/bash

set -e

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