#!/bin/bash

set -e
set -o pipefail

# Activate Rust environment
source $HOME/.cargo/env

# Install Python versions using uv
uv python install 3.12

# Start gnome-keyring daemon
echo 'foobar' | gnome-keyring-daemon --components=secrets --daemonize --unlock

# Install cargo-nextest
cargo install cargo-nextest

# Run cargo tests with nextest
cargo nextest run \
  --features python-patch,native-auth,secret-service \
  --workspace \
  --status-level skip --failure-output immediate-final --no-fail-fast -j 20 --final-status-level slow || true

# Ensure all tests are executed even if some fail