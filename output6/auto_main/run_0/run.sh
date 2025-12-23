#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
mvn -B dependency:go-offline -U --quiet --fail-never -DskipTests=true -f build-pom.xml

# Run tests
# Ensure all tests are executed, even if some fail
mvn -B verify -U --fail-at-end -Dsource.skip=true -Dmaven.javadoc.skip=true -f build-pom.xml