#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Note: Rust projects typically manage dependencies via Cargo.toml, so no additional steps needed here

# Run tests
# Ensure all tests are executed, even if some fail
set +e
cargo test --workspace --all-features
set -e