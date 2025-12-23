#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run Gradle build and test
./gradlew build test || true

# Ensure all tests are executed, even if some fail
./gradlew test --continue