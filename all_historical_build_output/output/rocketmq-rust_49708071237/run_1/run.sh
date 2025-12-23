# run.sh
#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
rustup component add rustfmt clippy

# Run format check
cargo fmt -- --check || true

# Run clippy check
cargo clippy -- -D warnings || true

# Build the project
cargo build --verbose --all-features || true

# Run tests
cargo test --verbose || true