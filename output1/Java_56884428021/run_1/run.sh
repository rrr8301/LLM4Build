#!/bin/bash

# Fail on any error
set -e

# Print commands
set -x

# Install project dependencies using Maven
mvn clean install

# Run tests (failures won't stop the test suite)
mvn test --fail-never

# Additional verification if needed
# mvn verify