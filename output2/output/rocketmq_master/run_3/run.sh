#!/bin/bash

# Install project dependencies and build
mvn -B package --file auth/pom.xml

# Run tests
mvn clean verify  # Ensure all tests run