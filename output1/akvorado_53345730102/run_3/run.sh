#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
go mod tidy

# Build the project
make

# Run tests, ensuring all tests are executed even if some fail
set +e
make test-go
TEST_EXIT_CODE=$?
set -e

# If Rust tools are used, ensure they are installed
if command -v cargo &> /dev/null; then
    # Run Rust-related checks or builds if necessary
    # Add RUST_BACKTRACE=1 to get more detailed error information
    RUST_BACKTRACE=1 cargo check || true
fi

# Exit with the test command's exit code
exit $TEST_EXIT_CODE