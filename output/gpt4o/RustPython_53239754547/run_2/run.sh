#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Format code and check style
cargo fmt --all -- --check
cargo clippy --workspace --all-targets --exclude rustpython_wasm -- -Dwarnings

# Install project dependencies
cargo install --path .

# Run rust tests with required features
set +e
cargo test --workspace --exclude rustpython_wasm --verbose --features stdlib,importlib,stdio,encodings,sqlite,ssl,threading
test_exit_code=$?
set -e

# Check compilation without threading
cargo check --features stdlib,importlib,stdio,encodings,sqlite,ssl

# Test example projects if on Linux
if [[ "$(uname)" == "Linux" ]]; then
    cargo run --manifest-path example_projects/barebone/Cargo.toml --features stdlib,importlib,stdio,encodings,sqlite,ssl
    cargo run --manifest-path example_projects/frozen_stdlib/Cargo.toml --features stdlib,importlib,stdio,encodings,sqlite,ssl
fi

# Exit with test status
exit $test_exit_code