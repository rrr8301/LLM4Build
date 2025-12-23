#!/bin/bash

# Activate rustup
source $HOME/.cargo/env

# Install Rust toolchains
rustup toolchain install stable
rustup toolchain install beta
rustup toolchain install nightly

# Run tests for each Rust version
for version in stable beta nightly; do
    echo "Running tests on Rust $version"
    rustup default $version
    cargo test --workspace --all-features || true
done