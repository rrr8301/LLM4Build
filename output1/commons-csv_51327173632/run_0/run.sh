#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# No specific environment activation needed for Java

# Install project dependencies and build
mvn -Ddoclint=all --show-version --batch-mode --no-transfer-progress

# Run tests
# Ensure all tests are executed, even if some fail
mvn test || true