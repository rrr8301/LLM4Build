#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mvn -B package --file pom.xml

# Run tests, continue even if some tests fail
mvn test || true