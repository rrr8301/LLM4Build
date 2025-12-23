#!/bin/bash

# Activate environments
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed by Cargo, Python, and Node.js
set +e  # Continue on error for build
cargo build --release --locked --all-targets --features=panic-trace
if [ $? -ne 0 ]; then
    echo "Build failed, exiting..."
    exit 1
fi
set -e  # Stop on error

# Run tests
set +e  # Continue on error for tests
cargo test --release --locked --features=panic-trace
test_exit_code=$?
set -e  # Stop on error

if [ $test_exit_code -ne 0 ]; then
    echo "Some tests failed"
    exit $test_exit_code
fi

echo "All tests completed successfully"