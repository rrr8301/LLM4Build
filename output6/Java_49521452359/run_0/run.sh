#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environment variables if any (none specified)

# Install project dependencies
# Maven will handle dependencies specified in pom.xml

# Run tests and ensure all tests are executed
mvn --batch-mode --update-snapshots verify || true

# Run Checkstyle
mvn checkstyle:check || true

# Run SpotBugs
mvn spotbugs:check || true

# Run PMD
mvn pmd:check || true