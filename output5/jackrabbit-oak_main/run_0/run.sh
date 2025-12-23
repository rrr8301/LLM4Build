#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies and run tests
# Ensure all tests are executed, even if some fail
set -e
mvn clean install || true
mvn clean install -PintegrationTesting || true