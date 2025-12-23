#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
# Assuming dependencies are managed by Go modules
go mod download

# Run tests
# Ensure all tests are executed, even if some fail
set +e
make CGO_ENABLED="${CGO_ENABLED}" BUILDARGS="${BUILDARGS}" TESTARGS="${TESTARGS}" ${MAKE_TARGET}
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE