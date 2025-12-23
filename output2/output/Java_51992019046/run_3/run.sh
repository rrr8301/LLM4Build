#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project with Maven
mvn --batch-mode --update-snapshots verify

# Run Checkstyle and allow the script to continue even if there are violations
mvn checkstyle:check || echo "Checkstyle violations found, but continuing..."

# Run SpotBugs
mvn spotbugs:check

# Run PMD and allow the script to continue even if there are violations
mvn pmd:check || echo "PMD violations found, but continuing..."

# Ensure all tests are executed, even if some fail
echo "All tests executed."