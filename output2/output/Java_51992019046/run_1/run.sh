#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project with Maven
mvn --batch-mode --update-snapshots verify

# Run Checkstyle
mvn checkstyle:check

# Run SpotBugs
mvn spotbugs:check

# Run PMD
mvn pmd:check

# Ensure all tests are executed, even if some fail
echo "All tests executed."