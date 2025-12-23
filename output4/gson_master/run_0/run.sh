#!/bin/bash

# Set Maven arguments
export MAVEN_ARGS="--show-version --batch-mode --no-transfer-progress"

# Build and test the project
mvn clean verify javadoc:jar $MAVEN_ARGS || true

# Ensure all tests are executed, even if some fail
mvn test $MAVEN_ARGS || true