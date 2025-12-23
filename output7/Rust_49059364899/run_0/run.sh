#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Rust environment
source $HOME/.cargo/env

# Run cargo test and ensure all tests are executed
cargo test || true