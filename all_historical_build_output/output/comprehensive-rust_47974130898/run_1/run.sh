#!/bin/bash

set -e

# Update Rust
rustup update

# Build Rust code
cargo build

# Run tests
cargo test