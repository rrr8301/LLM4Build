#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
./gradlew publishToMavenLocal

# Run all tests, do not skip any remaining tests
./gradlew build