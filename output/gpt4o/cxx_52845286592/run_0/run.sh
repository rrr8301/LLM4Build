#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build

# Run the application
cargo run --manifest-path demo/Cargo.toml

# Run tests
set +e  # Continue on error
cargo test --workspace
set -e  # Stop on error

# Additional checks
cargo check --no-default-features --features alloc
cargo check --no-default-features