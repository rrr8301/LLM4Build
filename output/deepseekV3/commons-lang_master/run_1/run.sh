#!/bin/bash

# Fail on any error
set -e

# Print commands as they're executed
set -x

# Install project dependencies
mvn dependency:go-offline

# Run tests with the same parameters as GitHub Actions but skip RAT checks
mvn --errors --show-version --batch-mode --no-transfer-progress -Ddoclint=all -Drat.skip=true test

# Run additional checks if needed (as mentioned in README)
# Note: RAT checks will run during the site phase
mvn clean site -Dcommons.jacoco.haltOnFailure=false -Pjacoco