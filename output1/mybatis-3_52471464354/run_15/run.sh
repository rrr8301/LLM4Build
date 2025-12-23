#!/bin/bash

# Activate the environment (if any specific activation is needed, otherwise skip)
# No specific environment activation needed for Java

# Install project dependencies
# Maven will handle dependencies during the test phase

# Run tests with Maven
# Ensure all tests are executed, even if some fail

# Check if the Maven wrapper script exists, otherwise use Maven directly
if [ -f "./mvnw" ]; then
    ./mvnw test -B -V --no-transfer-progress -D"license.skip=true" -D"enforcer.skip=true" -PtestContainers || true
else
    mvn test -B -V --no-transfer-progress -D"license.skip=true" -D"enforcer.skip=true" -PtestContainers || true
fi