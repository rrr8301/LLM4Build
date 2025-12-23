#!/bin/bash

# Activate environment (if any specific environment setup is needed, add here)

# Install project dependencies and build the project
./mvnw clean install -DskipTests=false

# Run tests
# Ensure all tests are executed, even if some fail
set +e
./mvnw test
set -e