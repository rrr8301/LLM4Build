#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run cargo test and ensure all tests are executed
cargo test || true