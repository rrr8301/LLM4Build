#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure we are in the correct directory where pom.xml is located
cd /app

# Install project dependencies and build the project
mvn clean install

# Run tests, ensuring all tests are executed even if some fail
mvn test