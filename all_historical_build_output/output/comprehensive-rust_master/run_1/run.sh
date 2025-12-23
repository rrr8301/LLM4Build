#!/bin/bash

set -e
set -o pipefail

# Activate Rust environment
source $HOME/.cargo/env

# Update Rust and set default to stable
rustup update
rustup default stable

# Build Rust code
cargo build

# Run Rust tests
cargo test

# Install mdbook and other tools
cargo xtask install-tools

# Test code snippets
mdbook test