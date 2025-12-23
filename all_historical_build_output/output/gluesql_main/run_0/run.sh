#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the environment (if any specific activation is needed, e.g., source a virtualenv)
# For Rust, this might not be necessary unless using a specific toolchain

# Install project dependencies
cargo build --release

# Run tests
# Ensure all tests are executed, even if some fail
cargo test || true