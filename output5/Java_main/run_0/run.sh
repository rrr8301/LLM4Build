#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project using Maven
mvn clean install

# Run tests, ensuring all tests are executed even if some fail
mvn test || true