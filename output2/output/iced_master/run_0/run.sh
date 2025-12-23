#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build --verbose --profile release-opt --package todos

# Run tests
cargo test --verbose --workspace || true
cargo test --verbose --workspace -- --ignored || true
cargo test --verbose --workspace --all-features || true

# Note: The '|| true' ensures that all tests are executed even if some fail.