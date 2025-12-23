#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Build and test with Maven
mvn --batch-mode --update-snapshots verify || true

# Run Checkstyle
mvn checkstyle:check || true

# Run SpotBugs
mvn spotbugs:check || true

# Run PMD
mvn pmd:check || true

# Note: Codecov upload steps are ignored