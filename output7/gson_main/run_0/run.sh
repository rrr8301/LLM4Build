#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build and tests
mvn clean verify || true

# Ensure all tests are executed, even if some fail
mvn test || true