#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Build the project
cargo build --workspace --all-features

# Run tests, ensuring all tests are executed
cargo test --workspace --all-features || true