#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environment (if any, placeholder here)
# source /path/to/env/bin/activate

# Install project dependencies
mvn clean install

# Run tests
# Ensure all tests are executed, even if some fail
mvn test || true