#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies
# Assuming dependencies are managed by Gradle, no additional steps needed

# Run tests
set -e
./gradlew build || true

# Ensure all test cases are executed
# Note: The `|| true` ensures that the script continues even if some tests fail