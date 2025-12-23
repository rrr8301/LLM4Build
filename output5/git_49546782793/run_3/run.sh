#!/bin/bash

set -e

# Switch to builder user
sudo --preserve-env --set-home --user=builder bash << 'EOF'

# Install project dependencies
./ci/install-dependencies.sh

# Run build and tests
set +e
./ci/run-build-and-tests.sh
TEST_RESULT=$?
set -e

# Print test failures if any
if [ $TEST_RESULT -ne 0 ]; then
    ./ci/print-test-failures.sh
fi

exit $TEST_RESULT

EOF