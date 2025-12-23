#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build without skipping tests
mvn clean verify

# Generate the classpath for the module path
MODULE_PATH=$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q -DincludeScope=test)

# Run all tests with module path configuration
# Ensure that the module path includes the dependencies
mvn test -Dmodule.path="${MODULE_PATH}:target/classes:target/test-classes" \
         -DskipTests=false \
         -Denforcer.skip=true \
         -Dlicense.skip=true