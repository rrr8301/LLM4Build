#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed via Cargo.toml
cargo build --verbose --all-features

# Run tests
# Ensure all tests are executed, even if some fail
set +e
cargo test --verbose --no-fail-fast
set -e