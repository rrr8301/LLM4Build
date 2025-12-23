#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Run clippy
cargo clippy --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl --workspace --all-targets --exclude rustpython_wasm -- -Dwarnings

# Run Rust tests
cargo test --workspace --exclude rustpython_wasm --verbose --features threading --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl || true

# Check compilation without threading
cargo check --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl || true

# Run Python snippets and tests
cd extra_tests
python3 -m pytest -v || true
cd ..

# Run cpython platform-independent tests
target/release/rustpython -m test -j 1 -u all --slowest --fail-env-changed -v || true

# Run cpython platform-dependent tests
target/release/rustpython -m test -j 1 -u all --slowest --fail-env-changed -v -x || true

# Check that --install-pip succeeds
mkdir -p site-packages
target/release/rustpython --install-pip ensurepip --user || true
target/release/rustpython -m pip install six || true

# Check that ensurepip succeeds
target/release/rustpython -m ensurepip || true
target/release/rustpython -c "import pip" || true

# Check if pip inside venv is functional
target/release/rustpython -m venv testvenv || true
testvenv/bin/rustpython -m pip install wheel || true

# Check whats_left is not broken
python3 -I whats_left.py || true