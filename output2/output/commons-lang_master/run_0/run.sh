#!/bin/bash

# Activate any necessary environments (none in this case)

# Install project dependencies and build
mvn --errors --show-version --batch-mode --no-transfer-progress -Ddoclint=all

# Run tests
# Ensure all tests are executed, even if some fail
mvn test || true