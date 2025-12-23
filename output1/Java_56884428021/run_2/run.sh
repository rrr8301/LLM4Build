#!/bin/bash

# Fail on any error
set -e

# Print commands
set -x

# Install project dependencies using Maven
mvn clean install -Denforcer.skip=true -Dlicense.skip=true

# Run all tests (including those that previously failed)
mvn test -Denforcer.skip=true -Dlicense.skip=true --fail-at-end

# Additional verification if needed
# mvn verify -Denforcer.skip=true -Dlicense.skip=true