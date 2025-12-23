#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo install --path .

# Run clippy
cargo clippy --workspace --all-targets --exclude rustpython_wasm -- -Dwarnings

# Run rust tests
cargo test --workspace --exclude rustpython_wasm --verbose --features threading

# Check compilation without threading
cargo check

# Test example projects
cargo run --manifest-path example_projects/barebone/Cargo.toml
cargo run --manifest-path example_projects/frozen_stdlib/Cargo.toml

# Ensure all tests are executed
set +e
cargo test --workspace --exclude rustpython_wasm --verbose --features threading
set -e