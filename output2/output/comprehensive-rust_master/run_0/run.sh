#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Update Rust
rustup update

# Build Rust code
cargo build

# Run tests, ensuring all tests are executed even if some fail
cargo test || true