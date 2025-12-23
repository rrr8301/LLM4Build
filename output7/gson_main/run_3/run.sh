#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build and tests with module path configuration
mvn clean verify -DskipTests

# Run all tests with module path configuration
# Ensure that the module path includes the dependencies
mvn test -Dmodule.path=target/classes:target/test-classes:$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q -DincludeScope=test)