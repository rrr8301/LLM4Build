#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies (none specified beyond Gradle)

# Run tests and generate coverage report
set -e
./gradlew build --stacktrace --scan || true
./gradlew coverageReport --stacktrace --scan || true

# Placeholder for uploading coverage report
echo "Upload coverage report manually or using another tool."