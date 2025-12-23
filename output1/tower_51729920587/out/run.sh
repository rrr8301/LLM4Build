#!/bin/bash

# Activate rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Assuming dependencies are managed by Cargo.toml

# Run tests
set +e  # Continue execution even if some tests fail
cargo test --workspace --all-features