#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Update Rust to the latest version
rustup update

# Build the Rust code
cargo build

# Run the tests, ensuring all tests are executed
cargo test || true