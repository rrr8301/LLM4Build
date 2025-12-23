#!/bin/bash

# Enable full backtrace for Rust errors
export RUST_BACKTRACE=full

# Install clippy component
rustup component add clippy

# Run clippy
echo "Running clippy..."
cargo clippy --workspace --all-targets --exclude rustpython_wasm --exclude rustpython-compiler-source -- -Dwarnings

# Run tests (continue even if some fail)
echo "Running tests..."
cargo test --workspace --exclude rustpython_wasm --exclude rustpython-compiler-source --verbose --features threading || true

# Check compilation without threading
echo "Checking compilation without threading..."
cargo check || true

# Test example projects with correct paths
echo "Testing example projects..."
cd /usr/src/rustpython
cargo run --manifest-path example_projects/barebone/Cargo.toml || true
cargo run --manifest-path example_projects/frozen_stdlib/Cargo.toml || true

echo "All test steps completed"