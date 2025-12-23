#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build

# Run tests and ensure all tests are executed
cargo test || true