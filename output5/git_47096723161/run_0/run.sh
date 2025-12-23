#!/bin/bash

# Run as builder user
sudo --preserve-env --set-home --user=builder bash << 'EOF'

# Install project dependencies
./ci/install-dependencies.sh

# Run build and tests
./ci/run-build-and-tests.sh

# Print test failures if any
if [ $? -ne 0 ] && [ ! -z "$FAILED_TEST_ARTIFACTS" ]; then
    ./ci/print-test-failures.sh
    echo "Artifacts would be uploaded here if this were a GitHub Action."
fi

EOF