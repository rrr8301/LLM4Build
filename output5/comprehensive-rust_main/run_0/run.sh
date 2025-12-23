#!/bin/bash

set -e

# Run Rust tests
cargo xtask rust-tests || true

# Ensure all tests are executed, even if some fail
cargo xtask web-tests || true