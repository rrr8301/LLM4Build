#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build --verbose --all-features

# Run tests, ensuring all tests are executed
set +e
cargo test --verbose
set -e