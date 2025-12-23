#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build and tests
# Assuming Maven is used; replace with Gradle commands if needed
mvn clean install -Denforcer.skip=true -Dlicense.skip=true

# Run tests
# Ensure all tests are executed, even if some fail
mvn test -Denforcer.skip=true -Dlicense.skip=true