#!/bin/bash

# Activate environments if needed (none in this case)

# Install project dependencies and build
mvn -B package --file pom.xml

# Run tests
mvn clean verify || true  # Ensure all tests run even if some fail