#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
./gradlew build

# Run tests, ensuring all tests are executed even if some fail
set +e
./gradlew test
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE