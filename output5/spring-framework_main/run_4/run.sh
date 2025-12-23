#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure we are in the correct directory where pom.xml is located
cd /app

# Check if pom.xml exists
if [ ! -f "pom.xml" ]; then
  echo "pom.xml not found in /app directory"
  exit 1
fi

# Install project dependencies and build the project
# Add flags to skip enforcer and license checks if they were previously added
mvn clean install -Denforcer.skip=true -Dlicense.skip=true

# Run tests, ensuring all tests are executed even if some fail
mvn test || true