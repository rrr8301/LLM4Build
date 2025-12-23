#!/bin/bash

# Activate environments if necessary (none specified)

# Install project dependencies
cargo build --release

# Run tests and ensure all tests are executed
cargo test -- --no-fail-fast