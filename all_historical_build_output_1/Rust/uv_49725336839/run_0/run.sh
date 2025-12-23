#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install Python versions using uv
uv python install

# Start gnome-keyring
echo 'foobar' | gnome-keyring-daemon --components=secrets --daemonize --unlock

# Run cargo tests
cargo nextest run \
  --features python-patch,native-auth,secret-service \
  --workspace \
  --status-level skip --failure-output immediate-final --no-fail-fast -j 20 --final-status-level slow || true