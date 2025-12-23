#!/bin/bash

set -e
set -o pipefail

# Switch to builder user
sudo --preserve-env --set-home --user=builder bash << 'EOF'

# Install dependencies
./ci/install-dependencies.sh

# Install Rust toolchain
./ci/install-rustup.sh
./ci/install-rust-toolchain.sh

# Run build and tests
./ci/run-build-and-tests.sh || true

# Print test failures if any
if [ -n "$FAILED_TEST_ARTIFACTS" ]; then
    ./ci/print-test-failures.sh
fi

EOF