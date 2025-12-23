#!/bin/bash

# Activate Rust environment
source "$HOME/.cargo/env"

# Ensure git symlinks are properly configured
git config --global core.symlinks true

# Initialize git repository with symlinks if not already done
if [ ! -d .git ]; then
    git init
    git config core.symlinks true
    git remote add origin https://github.com/dtolnay/cxx.git
    git fetch
    git checkout -f main
fi

# Install project dependencies
cargo build

# Run the application
cargo run --manifest-path demo/Cargo.toml

# Run tests (excluding cxx-test-suite as per YAML)
set +e  # Continue on error
cargo test --workspace --exclude cxx-test-suite
set -e  # Stop on error

# Additional checks
cargo check --no-default-features --features alloc
cargo check --no-default-features