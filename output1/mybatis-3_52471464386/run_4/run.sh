#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Check if the Maven wrapper exists and is executable
if [ -x "./mvnw" ]; then
    MVN_CMD="./mvnw"
else
    MVN_CMD="mvn"
fi

# Install project dependencies using Maven
$MVN_CMD clean install

# Run tests with Maven, ensuring all tests are executed
set +e  # Continue on error
$MVN_CMD test -B -V --no-transfer-progress -D"license.skip=true" -PtestContainers
set -e  # Stop on error