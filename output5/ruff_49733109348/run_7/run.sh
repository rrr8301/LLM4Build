#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Placeholder for any additional setup

# Run tests
set +e  # Continue on errors
cargo insta test --release --all-features --unreferenced reject --test-runner nextest