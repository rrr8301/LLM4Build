#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)

# Install project dependencies and build
mvn --errors --show-version --batch-mode --no-transfer-progress -Ddoclint=none

# Run tests
# Ensure all tests are executed, even if some fail
mvn test || true