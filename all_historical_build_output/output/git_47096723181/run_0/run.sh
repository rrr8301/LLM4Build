#!/bin/bash

# Run as 'builder' user
sudo --preserve-env --set-home --user=builder bash << 'EOF'

# Install dependencies
./ci/install-dependencies.sh

# Run build and tests
./ci/run-build-and-tests.sh

# Print test failures if any
if [ $? -ne 0 ] && [ -n "$FAILED_TEST_ARTIFACTS" ]; then
    ./ci/print-test-failures.sh
fi

EOF