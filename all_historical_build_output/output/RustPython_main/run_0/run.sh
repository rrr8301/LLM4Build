#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed by Cargo
cargo fetch

# Build the project
cargo build --release

# Run tests
# Ensure all tests are executed, even if some fail
cargo test --release || true