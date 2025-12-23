#!/bin/bash

# Fail on any error
set -e

# Print commands as they're executed
set -x

# Install project dependencies
mvn dependency:go-offline

# Run tests with the same parameters as GitHub Actions
mvn --errors --show-version --batch-mode --no-transfer-progress -Ddoclint=all test

# Run additional checks if needed (as mentioned in README)
mvn clean site -Dcommons.jacoco.haltOnFailure=false -Pjacoco