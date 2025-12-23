#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build without skipping tests
mvn clean verify

# Run all tests with module path configuration
# Ensure that the module path includes the dependencies
# Correct the way the module path is set
mvn test -Dmodule.path="$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q -DincludeScope=test):target/classes:target/test-classes" \
         -DskipTests=false \
         -Denforcer.skip=true \
         -Dlicense.skip=true