#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Placeholder for any additional setup

# Run tests
set -e
set -o pipefail
cargo insta test --release --all-features --unreferenced reject --test-runner nextest || true

# Ensure all tests are executed
exit 0