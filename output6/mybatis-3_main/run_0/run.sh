#!/bin/bash

# Activate environment variables
export TEST_CONTAINERS_PROFILE="-PtestContainers"

# Run Maven tests
# Ensure all tests are executed, even if some fail
set +e
./mvnw test -B -V --no-transfer-progress -D"license.skip=true" $TEST_CONTAINERS_PROFILE
set -e