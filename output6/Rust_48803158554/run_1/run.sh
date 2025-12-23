#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Rust environment
source $HOME/.cargo/env

# Navigate to the directory containing Cargo.toml
cd /app/.github/workflows/scripts/build_directory

# Install project dependencies
cargo build

# Run tests
cargo test