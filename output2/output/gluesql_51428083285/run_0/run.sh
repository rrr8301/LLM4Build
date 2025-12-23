#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Rust environment
source $HOME/.cargo/env

# Navigate to the storages directory and run tests
cd storages

# Run tests in each storage directory
for dir in memory-storage shared-memory-storage composite-storage json-storage csv-storage parquet-storage file-storage redb-storage sled-storage; do
    cd $dir
    if [ "$dir" == "sled-storage" ]; then
        cargo test --verbose -- --skip sled_transaction_timeout || true
        cargo test sled_transaction_timeout --verbose -- --test-threads=1 || true
        cargo test --benches || true
    else
        cargo test --verbose || true
    fi
    cd ..
done