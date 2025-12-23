#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Assuming dependencies are managed by Cargo.toml
cargo build

# Run tests
# Ensure all tests are executed, even if some fail
cargo test --all-features || true