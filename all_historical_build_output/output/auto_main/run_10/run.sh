#!/bin/bash

# Navigate to the directory containing the pom.xml
cd /app

# Install project dependencies
mvn install -Denforcer.skip=true -Dlicense.skip=true

# Run tests
mvn test  # Run all tests without skipping