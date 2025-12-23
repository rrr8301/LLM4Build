#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests with verbose output to get more information
# Ensure that the necessary features are enabled
cargo test --features "util balance buffer limit" -- --nocapture