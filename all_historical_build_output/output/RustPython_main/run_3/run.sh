#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build --release

# Run tests
# Ensure all tests are executed, even if some fail
cargo test -- --no-fail-fast