# run.sh
#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
rustup component add rustfmt clippy

# Run format check
cargo fmt -- --check

# Run clippy check, allowing the specific warning
cargo clippy -- -A clippy::derivable_impls -D warnings

# Build the project
cargo build --verbose --all-features

# Run tests
cargo test --verbose