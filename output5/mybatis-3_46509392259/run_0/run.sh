#!/bin/bash
set -euo pipefail

# Set environment variable as per the GitHub Actions step
export TEST_CONTAINERS_PROFILE=-PtestContainers

# Run Maven tests with the same flags as in the GitHub Actions job
./mvnw test -B -V --no-transfer-progress -Dlicense.skip=true $TEST_CONTAINERS_PROFILE