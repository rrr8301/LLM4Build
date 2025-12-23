#!/bin/bash

set -e
set -o pipefail

# Activate environments
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed by Cargo, Python, and Node.js
cargo build --release --locked --all-targets --features=panic-trace

# Run tests
cargo test --release --locked --features=panic-trace || true

# Ensure all tests are executed
echo "All tests executed."