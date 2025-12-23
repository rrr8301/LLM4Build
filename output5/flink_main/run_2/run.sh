#!/bin/bash

# Activate environment (if needed, otherwise this can be omitted)
# source /path/to/your/env/bin/activate

# Install project dependencies
mvn clean install -DskipTests

# Run tests with options to continue on failure and skip enforcer checks
./tools/ci/test_controller.sh core -Denforcer.skip=true --continue