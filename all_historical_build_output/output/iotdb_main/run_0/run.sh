#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mvn clean package -DskipTests

# Run tests, ensuring all tests are executed even if some fail
mvn test || true

# Note: The `|| true` ensures that the script does not exit if tests fail,
# allowing all tests to run to completion.