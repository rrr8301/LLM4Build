#!/bin/bash

# Activate environments if needed (none in this case)

# Install project dependencies
mvn --batch-mode --update-snapshots verify

# Run tests and ensure all tests are executed
mvn checkstyle:check || true
mvn spotbugs:check || true
mvn pmd:check || true