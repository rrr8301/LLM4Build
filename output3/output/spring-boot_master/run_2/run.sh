#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies and build
./gradlew --warning-mode all build

# Run tests
# Ensure all tests are executed, even if some fail
set +e
./gradlew --warning-mode all test
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE