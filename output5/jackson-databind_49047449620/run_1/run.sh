#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate any necessary environments (none in this case)

# Install project dependencies and build the project
mvn -B -ff -ntp verify

# Run tests and ensure all test cases are executed
set +e
mvn -B -q -ff -ntp test
TEST_EXIT_CODE=$?

# Exit with the test exit code
exit $TEST_EXIT_CODE