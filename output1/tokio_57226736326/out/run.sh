#!/bin/bash

# Enable error handling and verbose output
set -euxo pipefail

# Change to tokio directory
cd tokio

# Run tests with cargo-nextest (features full)
cargo nextest run --features full

# Run doc tests (features full)
cargo test --doc --features full

# Continue even if some tests fail
exit 0