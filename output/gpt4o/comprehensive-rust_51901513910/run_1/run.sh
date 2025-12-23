#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Update Rust to the latest version
rustup update

# Build the Rust code
cargo build

# Run all tests without skipping
cargo test --no-fail-fast || true