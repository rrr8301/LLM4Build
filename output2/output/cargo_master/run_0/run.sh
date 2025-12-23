#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Run cargo commands
cargo fmt --all --check
cargo clippy --workspace --all-targets --no-deps -- -D warnings
cargo test --workspace --exclude benchsuite --exclude resolver-tests || true
cargo test -p benchsuite --all-targets -- cargo || true
cargo check -p capture || true
cargo test -p cargo-util-schemas -F unstable-schema || true
cargo test -p resolver-tests || true
CARGO_USE_GITOXIDE_INSTEAD_OF_GIT2=1 cargo test -p cargo || true