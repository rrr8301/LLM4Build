#!/bin/bash

# Activate environments
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed by Cargo, Python, and Node.js
cargo build --release --locked --all-targets --features=panic-trace

# Run tests
set +e  # Continue on error
cargo test --release --locked --features=panic-trace
set -e  # Stop on error