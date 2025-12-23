#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo xtask install-tools

# Build Rust code
cargo build

# Run tests, ensuring all tests are executed
set +e
cargo test --all-features --no-fail-fast
set -e