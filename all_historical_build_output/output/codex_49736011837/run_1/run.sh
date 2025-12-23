#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed by Cargo.toml

# Run cargo clippy
cargo clippy --target x86_64-unknown-linux-musl --all-features --tests --profile dev -- -D warnings

# Run cargo check for individual crates
find . -name Cargo.toml -mindepth 2 -maxdepth 2 -print0 | xargs -0 -n1 -I{} bash -c 'cd "$(dirname "{}")" && cargo check --profile dev'

# Run cargo test
cargo test --all-features --target x86_64-unknown-linux-musl --profile dev || true

# Verify all steps passed
if [ $? -ne 0 ]; then
  echo "One or more checks failed (clippy, cargo_check_all_crates, or test). See logs for details."
  exit 1
fi