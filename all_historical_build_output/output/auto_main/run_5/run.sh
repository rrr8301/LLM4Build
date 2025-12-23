#!/bin/bash

# Navigate to the directory containing the pom.xml
cd /app

# Install project dependencies
mvn install -Denforcer.skip=true -Dlicense.skip=true

# Run tests
mvn verify  # Run all tests without skipping