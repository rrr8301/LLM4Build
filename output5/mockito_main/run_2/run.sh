#!/bin/bash

set -e
set -o pipefail

# Ensure gradlew is executable
chmod +x ./gradlew

# Build and test the project
./gradlew build --stacktrace --scan

# Generate coverage report
./gradlew coverageReport --stacktrace --scan

# Placeholder for uploading coverage report
echo "Upload the coverage report manually or use a local script."