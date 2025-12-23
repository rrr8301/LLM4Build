#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure Maven is installed and in the PATH
if ! command -v mvn &> /dev/null; then
    echo "Maven could not be found, please ensure it is installed."
    exit 1
fi

# Run Maven build without skipping tests
echo "Running Maven clean verify..."
mvn clean verify -Denforcer.skip=true -Dlicense.skip=true

# Generate the classpath for the module path
echo "Generating module path..."
MODULE_PATH=$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q -DincludeScope=test)

# Check if MODULE_PATH is empty
if [ -z "$MODULE_PATH" ]; then
    echo "Failed to generate module path."
    exit 1
fi

# Run all tests with module path configuration
# Ensure that the module path includes the dependencies
echo "Running tests with module path configuration..."
mvn test -Dmodule.path="${MODULE_PATH}:target/classes:target/test-classes" \
         -DskipTests=false \
         -Denforcer.skip=true \
         -Dlicense.skip=true