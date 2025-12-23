#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies
# Assuming dependencies are managed by Gradle, no additional steps needed

# Run tests
set -e
./gradlew build

# Ensure all test cases are executed
# Removed the `|| true` to ensure the script fails if any test fails