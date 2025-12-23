#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Build the project using Gradle
./gradlew build --no-daemon

# Run tests
./gradlew test --no-daemon