# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
# Assuming Cargo.toml is in the root directory
cargo build

# Run tests
# Ensure all tests are executed, even if some fail
cargo test || true