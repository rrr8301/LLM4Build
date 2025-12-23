#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build --locked

# Run tests
set +e  # Continue on error
cargo test --locked --release --all-features --all-targets
set -e  # Stop on error

# Measure coverage
./admin/coverage --lcov --output-path final.info

# Placeholder for manual upload or local storage of coverage reports
echo "Coverage report generated at final.info. Please upload manually."