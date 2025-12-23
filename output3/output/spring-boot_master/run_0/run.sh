#!/bin/bash

# Activate environments if needed (none in this case)

# Install project dependencies and build
./gradlew build

# Run tests
# Ensure all tests are executed, even if some fail
set +e
./gradlew test
set -e