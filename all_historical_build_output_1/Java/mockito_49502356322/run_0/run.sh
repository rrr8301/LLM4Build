#!/bin/bash

# Activate environment variables if needed (none in this case)

# Install project dependencies using Gradle wrapper
./gradlew build

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
./gradlew test --stacktrace --scan
set -e  # Re-enable exit on error

# Generate coverage report
./gradlew coverageReport --stacktrace --scan

# Note: Uploading coverage report is skipped due to lack of CODECOV_TOKEN