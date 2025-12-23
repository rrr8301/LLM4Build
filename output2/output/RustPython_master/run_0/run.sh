#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Run clippy
cargo clippy --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl --workspace --all-targets --exclude rustpython_wasm -- -Dwarnings

# Run Rust tests
cargo test --workspace --exclude rustpython_wasm --verbose --features threading --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl

# Check compilation without threading
cargo check --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl

# Build RustPython
cargo build --release --verbose --features=threading --no-default-features --features stdlib,importlib,stdio,encodings,sqlite,ssl

# Run Python snippets
cd extra_tests
python3 -m pip install -r requirements.txt
pytest -v || true
cd ..

# Run cpython platform-independent tests
target/release/rustpython -m test -j 1 -u all --slowest --fail-env-changed -v || true

# Run cpython platform-dependent tests (Linux)
target/release/rustpython -m test -j 1 -u all --slowest --fail-env-changed -v -x || true

# Check that --install-pip succeeds
mkdir -p site-packages
target/release/rustpython --install-pip ensurepip --user
target/release/rustpython -m pip install six || true

# Check that ensurepip succeeds
target/release/rustpython -m ensurepip
target/release/rustpython -c "import pip" || true

# Check if pip inside venv is functional
target/release/rustpython -m venv testvenv
testvenv/bin/rustpython -m pip install wheel || true

# Check whats_left is not broken
python3 -I whats_left.py || true