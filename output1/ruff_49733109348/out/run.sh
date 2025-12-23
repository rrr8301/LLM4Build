#!/bin/bash

# Clone repository if not already copied (alternative to COPY in Dockerfile)
if [ ! -f Cargo.toml ]; then
    echo "Repository not found, cloning..."
    git clone https://github.com/astral-sh/ruff.git .
fi

# Show Rust toolchain
rustup show

# Run tests with cargo insta and nextest
echo "Running tests..."
cargo insta test --release --all-features --unreferenced reject --test-runner nextest

# Ensure script exits with test result status
exit $?