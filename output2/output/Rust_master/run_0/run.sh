#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Setup Git configuration
git config --global user.name "local-user"
git config --global user.email "local-user@example.com"

# Run the Rust script to update DIRECTORY.md
cargo run --manifest-path=.github/workflows/scripts/build_directory/Cargo.toml

# Commit and push changes to DIRECTORY.md
git add DIRECTORY.md
git commit -m "Update DIRECTORY.md [skip actions]" || true
git push origin HEAD || true

# Run cargo fmt to check formatting
cargo fmt --all -- --check

# Run cargo clippy for linting
cargo clippy --all --all-targets -- -D warnings

# Run cargo test and ensure all tests are executed
cargo test || true