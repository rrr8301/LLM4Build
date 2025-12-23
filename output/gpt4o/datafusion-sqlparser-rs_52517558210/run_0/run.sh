#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build

# Run tests
set +e  # Continue execution even if some tests fail
cargo test --all-features