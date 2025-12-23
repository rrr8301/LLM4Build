#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environment variables if needed (none specified in the task)

# Install project dependencies
./gradlew publishToMavenLocal

# Run all tests, continue even if some fail
./gradlew build --continue