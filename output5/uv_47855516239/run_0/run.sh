#!/bin/bash

# Activate the Rust environment
source $HOME/.cargo/env

# Install the Rust toolchain
rustup show

# Install cargo nextest
cargo install cargo-nextest

# Run cargo tests with nextest
cargo nextest run \
  --features python-patch \
  --workspace \
  --status-level skip --failure-output immediate-final --no-fail-fast -j 20 --final-status-level slow || true

# Ensure all tests are executed, even if some fail