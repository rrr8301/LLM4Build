#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build --release

# Run tests
# Run all tests and continue even if some fail
set +e  # Disable exit on error
cargo test
TEST_EXIT_CODE=$?  # Capture the exit code of the tests
set -e  # Re-enable exit on error

# Exit with the test exit code
exit $TEST_EXIT_CODE