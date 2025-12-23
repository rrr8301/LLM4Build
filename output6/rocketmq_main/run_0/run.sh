#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environment (if any specific environment setup is needed, add here)

# Install project dependencies and run tests
mvn clean install || true

# Ensure all tests are executed, even if some fail
mvn test || true