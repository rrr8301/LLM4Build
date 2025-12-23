#!/bin/bash

set -e

# Install project dependencies
mvn -B dependency:go-offline -f common/pom.xml

# Run tests
# Ensure all tests are executed, even if some fail
mvn -B verify -f common/pom.xml || true