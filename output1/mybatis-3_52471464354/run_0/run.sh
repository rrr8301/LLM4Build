#!/bin/bash

# Activate the environment (if any specific activation is needed, otherwise skip)
# No specific environment activation needed for Java

# Install project dependencies
# Maven will handle dependencies during the test phase

# Run tests with Maven
# Ensure all tests are executed, even if some fail
set +e
./mvnw test -B -V --no-transfer-progress -D"license.skip=true" -PtestContainers
set -e