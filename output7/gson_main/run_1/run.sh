#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build and tests
mvn clean verify

# Run all tests
mvn test