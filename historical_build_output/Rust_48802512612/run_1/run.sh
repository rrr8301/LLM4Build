#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Assuming no additional dependencies are needed beyond Rust toolchain

# Run tests
set +e  # Continue executing even if some tests fail
cargo test -- --nocapture