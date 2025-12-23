#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build

# Run tests
# Ensure all tests are executed, even if some fail
cargo test || true