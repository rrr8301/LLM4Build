#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to run tests and ensure all tests are executed
run_tests() {
    mvn -B package --file pom.xml || true
}

# Activate the environment (if any specific activation is needed)
# For Java, typically no activation is needed

# Install project dependencies and run tests
run_tests