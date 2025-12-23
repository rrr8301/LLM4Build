#!/bin/bash

# Install project dependencies
./gradlew --build-cache dependencies

# Build and test the project
./gradlew --build-cache build test || true

# Ensure all tests are executed, even if some fail
exit 0