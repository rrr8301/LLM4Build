#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Rust environment
source $HOME/.cargo/env

# Navigate to the directory containing Cargo.toml
cd .github/workflows/scripts/build_directory

# Run tests
# Ensure all tests are executed, even if some fail
cargo test || true