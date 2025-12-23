#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# For Rust, dependencies are typically specified in Cargo.toml and handled by cargo

# Build the project
cargo build --release

# Run tests
# Ensure all tests are executed, even if some fail
cargo test -- --continue-on-error