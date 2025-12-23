#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Assuming dependencies are managed by Cargo.toml, no additional steps needed

# Run tests
set +e  # Continue execution even if some tests fail
cargo test --workspace --all-features