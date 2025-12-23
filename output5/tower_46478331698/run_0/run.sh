#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install Rust toolchain
rustup toolchain install stable
rustup default stable

# Run tests
set +e  # Continue on errors
cargo test --workspace --all-features