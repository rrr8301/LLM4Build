#!/bin/bash

# Activate environment variables
export TEST_CONTAINERS_PROFILE="-PtestContainers"

# Install project dependencies
mvn install

# Run tests
mvn test -B -V --no-transfer-progress -D"license.skip=true" $TEST_CONTAINERS_PROFILE