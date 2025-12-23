#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Rust environment
source $HOME/.cargo/env

# Run tests in all specified directories
set +e  # Allow script to continue even if some tests fail
cd core && cargo test --verbose && cd ..
cd utils && cargo test --verbose && cd ..
cd cli && cargo test --verbose && cd ..
cd pkg/rust
cargo test --lib --bins --tests --examples --verbose --no-default-features --features "gluesql_memory_storage gluesql_sled_storage"
cd ../../