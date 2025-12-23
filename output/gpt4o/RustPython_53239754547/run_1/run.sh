#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo install --path .

# Run clippy
cargo clippy --workspace --all-targets --exclude rustpython_wasm -- -Dwarnings

# Run rust tests with required features
cargo test --workspace --exclude rustpython_wasm --verbose --features stdlib,importlib,stdio,encodings,sqlite,ssl,threading

# Check compilation without threading
cargo check --features stdlib,importlib,stdio,encodings,sqlite,ssl

# Test example projects
cargo run --manifest-path example_projects/barebone/Cargo.toml --features stdlib,importlib,stdio,encodings,sqlite,ssl
cargo run --manifest-path example_projects/frozen_stdlib/Cargo.toml --features stdlib,importlib,stdio,encodings,sqlite,ssl

# Ensure all tests are executed
set +e
cargo test --workspace --exclude rustpython_wasm --verbose --features stdlib,importlib,stdio,encodings,sqlite,ssl,threading
set -e