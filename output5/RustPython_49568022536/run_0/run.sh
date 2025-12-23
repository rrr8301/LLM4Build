# run.sh
#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Run clippy
cargo clippy --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl --workspace --all-targets --exclude rustpython_wasm -- -Dwarnings

# Run rust tests
cargo test --workspace --exclude rustpython_wasm --verbose --features threading --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl || true

# Check compilation without threading
cargo check --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl

# Test example projects
cargo run --manifest-path example_projects/barebone/Cargo.toml || true
cargo run --manifest-path example_projects/frozen_stdlib/Cargo.toml || true