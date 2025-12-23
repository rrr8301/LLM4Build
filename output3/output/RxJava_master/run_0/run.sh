#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project using Gradle
./gradlew build

# Run tests
./gradlew test || true  # Continue running even if some tests fail