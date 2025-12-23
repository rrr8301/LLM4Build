#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Placeholder for any additional setup

# Run formatting check
cargo fmt --all --check

# Run clippy for linting
cargo clippy --workspace --all-targets --no-deps -- -D warnings

# Run tests
set +e  # Continue on errors
cargo test --workspace --exclude benchsuite --exclude resolver-tests
cargo test -p cargo --test build-std
cargo test -p cargo-util-schemas -F unstable-schema
cargo test -p resolver-tests
cargo test -p cargo
set -e  # Stop on errors

# Note: Environment variables for specific tests are set within the script
CARGO_RUN_BUILD_STD_TESTS=1 cargo test -p cargo --test build-std
__CARGO_USE_GITOXIDE_INSTEAD_OF_GIT2=1 cargo test -p cargo