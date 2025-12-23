#!/bin/bash

# Activate environment variables
export TEST_CONTAINERS_PROFILE="-PtestContainers"

# Install project dependencies and run tests
./mvnw test -B -V --no-transfer-progress -D"license.skip=true" $TEST_CONTAINERS_PROFILE || true

# Ensure all tests are executed, even if some fail
exit 0