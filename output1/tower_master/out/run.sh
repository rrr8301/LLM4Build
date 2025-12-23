#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo update

# Build the project
cargo build --workspace --all-features

# Run tests, ensuring all tests are executed even if some fail
cargo test --workspace --all-features || true