#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
cargo build --release

# Run tests
# Ensure all tests are executed, even if some fail
cargo test -- --no-fail-fast