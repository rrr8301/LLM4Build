#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Install project dependencies
./gradlew publishToMavenLocal

# Run all tests, do not skip any remaining tests
./gradlew build --stacktrace --info