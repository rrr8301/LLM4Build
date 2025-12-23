#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# For Rust, dependencies are usually specified in Cargo.toml and handled by cargo itself

# Run tests
# Ensure all tests are executed, even if some fail
set +e
cargo test
set -e