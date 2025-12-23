#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo fetch

# Run the project
cargo run --manifest-path demo/Cargo.toml

# Run tests
cargo test --workspace || true

# Run additional checks
RUSTFLAGS="--cfg compile_error_if_std" cargo check --no-default-features --features alloc || true
RUSTFLAGS="--cfg compile_error_if_alloc --cfg cxx_experimental_no_alloc" cargo check --no-default-features || true

# Ensure all tests are executed, even if some fail