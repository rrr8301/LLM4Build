#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Assuming dependencies are managed via Cargo.toml

# Run tests
set +e  # Continue on errors
cargo test
cargo test --no-default-features
cargo test --features span-locations
RUSTFLAGS='--cfg procmacro2_semver_exempt' cargo test
RUSTFLAGS='--cfg procmacro2_semver_exempt' cargo test --no-default-features
set -e  # Stop on errors