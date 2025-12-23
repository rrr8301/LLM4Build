#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven to install dependencies and run tests
# Ensure all tests are executed, even if some fail
mvn clean install || true
mvn test || true