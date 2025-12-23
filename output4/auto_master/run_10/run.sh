#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
mvn -B dependency:go-offline -f build-pom.xml

# Ensure the missing dependency is installed
cd common
mvn clean install
cd /app

# Check if the missing dependency is available in the local repository
if ! mvn dependency:get -Dartifact=com.google.auto.service:auto-service-annotations:jar:HEAD-SNAPSHOT; then
    echo "Building and installing auto-service-annotations from source..."
    # Assuming the source is available in a directory named 'auto-service-annotations'
    if [ -d "auto-service-annotations" ]; then
        cd auto-service-annotations
        mvn clean install
        cd /app
    else
        echo "Error: auto-service-annotations source directory not found."
        exit 1
    fi
fi

# Build the auto-service project to ensure all dependencies are available
cd auto-service
mvn clean install
cd /app

# Build the main project
mvn clean install -f build-pom.xml

# Run tests, ensuring all tests are executed even if some fail
mvn -B verify -f build-pom.xml || true