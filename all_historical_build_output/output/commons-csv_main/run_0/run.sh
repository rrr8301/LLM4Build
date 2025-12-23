#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project with Maven
mvn -Ddoclint=all --show-version --batch-mode --no-transfer-progress install

# Run tests, ensuring all tests are executed even if some fail
mvn test || true