#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build and tests with module path configuration
mvn clean verify -DskipTests

# Run all tests with module path configuration
mvn test -Dmodule.path=target/classes:target/test-classes