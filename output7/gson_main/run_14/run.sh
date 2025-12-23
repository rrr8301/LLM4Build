#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure Maven is installed and in the PATH
if ! command -v mvn &> /dev/null; then
    echo "Maven could not be found, please ensure it is installed."
    exit 1
fi

# Run Maven build without skipping tests
exec mvn clean verify -Denforcer.skip=true -Dlicense.skip=true

# Generate the classpath for the module path
MODULE_PATH=$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q -DincludeScope=test)

# Run all tests with module path configuration
# Ensure that the module path includes the dependencies
exec mvn test -Dmodule.path="${MODULE_PATH}:target/classes:target/test-classes" \
         -DskipTests=false \
         -Denforcer.skip=true \
         -Dlicense.skip=true