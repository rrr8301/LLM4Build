#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo update

# Build the project
cargo build --workspace --all-features

# Run tests and ensure all tests are executed
cargo test --workspace --all-features || true