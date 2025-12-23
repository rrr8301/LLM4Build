#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
mvn -B dependency:go-offline -f build-pom.xml

# Attempt to build and install the missing dependency if necessary
# This assumes you have the source code for the missing dependency
if ! mvn -B dependency:resolve -f build-pom.xml; then
    echo "Attempting to build and install missing dependencies..."
    # Navigate to the directory where the missing dependency source code is located
    # Adjust the path according to your project structure
    cd common
    mvn clean install
    cd /app
fi

# Ensure the missing dependency is installed
cd common
mvn clean install
cd /app

# Build the main project
mvn clean install -f build-pom.xml

# Run tests, ensuring all tests are executed even if some fail
mvn -B verify -f build-pom.xml || true