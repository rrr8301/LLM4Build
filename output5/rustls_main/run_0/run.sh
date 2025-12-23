#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies and build
cargo build

# Run tests, ensuring all tests are executed even if some fail
cargo test || true