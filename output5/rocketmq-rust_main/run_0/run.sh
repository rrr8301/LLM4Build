#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests, ensuring all tests are executed even if some fail
cargo test -- --no-fail-fast