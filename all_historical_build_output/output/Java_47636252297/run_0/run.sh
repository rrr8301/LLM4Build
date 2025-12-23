#!/bin/bash

# run.sh

# Set Java home
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

# Build with Maven
mvn --batch-mode --update-snapshots verify

# Simulate Codecov upload (tokenless)
# Placeholder for Codecov upload step (tokenless)

# Simulate Codecov upload (with token)
# Placeholder for Codecov upload step (with token)

# Run Checkstyle
mvn checkstyle:check || true

# Run SpotBugs
mvn spotbugs:check || true

# Run PMD
mvn pmd:check || true

# Ensure all tests are executed, even if some fail