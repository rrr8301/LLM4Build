#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Run tests in all specified directories
set +e
cd core && cargo test --verbose
cd ../utils && cargo test --verbose
cd ../cli && cargo test --verbose
cd ../pkg/rust && cargo test --lib --bins --tests --examples --verbose --no-default-features --features "gluesql_memory_storage gluesql_sled_storage"
cd ../../
set -e