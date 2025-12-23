#!/bin/bash

# Activate uv environment
uv venv

# Install Python dependencies
uv pip install -r ./scripts/requirements.txt

# Add Rust components
rustup component add rustfmt rustc-dev

# Run cargo format check
export RUSTFLAGS="-D warnings"
export RUSTDOCFLAGS="-D warnings"
cargo fmt --check

# Build the project
cargo build --release

# Run tests
set +e  # Continue on errors
cargo test --release --workspace
uv run ./scripts/test_translator.py tests/
set -e  # Stop on errors