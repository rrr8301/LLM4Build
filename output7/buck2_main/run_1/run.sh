#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# For Rust, dependencies are typically specified in Cargo.toml and handled by cargo

# Build the project
cargo build --release

# Run tests for each package individually
for package in $(cargo metadata --format-version=1 --no-deps | jq -r '.packages[].name'); do
    echo "Running tests for package: $package"
    cargo test -p "$package" || true
done