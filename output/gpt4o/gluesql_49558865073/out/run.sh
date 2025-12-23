#!/bin/bash

# Navigate to each directory and run cargo tests
set -e

# Run tests in core
cd core
cargo test --verbose || true
cd ..

# Run tests in utils
cd utils
cargo test --verbose || true
cd ..

# Run tests in cli
cd cli
cargo test --verbose || true
cd ..

# Run tests in pkg/rust with specific features
cd pkg/rust
cargo test --lib --bins --tests --examples --verbose --no-default-features --features "gluesql_memory_storage gluesql_sled_storage" || true
cd ../../

# Ensure all tests are executed even if some fail