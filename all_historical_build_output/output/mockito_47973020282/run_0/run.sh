#!/bin/bash

set -e

# Activate environment variables if needed
export JAVA_HOME=/opt/java/openjdk
export PATH="$JAVA_HOME/bin:$PATH"

# Install project dependencies
./gradlew --no-daemon build

# Run tests and ensure all tests are executed
set +e
./gradlew --no-daemon test
TEST_EXIT_CODE=$?

# Generate coverage report
./gradlew --no-daemon coverageReport

# Exit with the test exit code
exit $TEST_EXIT_CODE