#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed by Cargo
cargo build

# Run tests
set +e  # Continue on errors
just build-wasm
just test-ci