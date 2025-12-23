#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Update system package info
sudo --preserve-env=http_proxy apt-get update

# Install system dependencies
sudo --preserve-env=http_proxy python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive watchman
sudo --preserve-env=http_proxy python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Query paths (output is ignored in this script)
python3 build/fbcode_builder/getdeps.py --allow-system-packages query-paths --recursive --src-dir=. watchman

# Build Watchman
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. watchman --project-install-prefix watchman:/usr/local

# Copy artifacts
python3 build/fbcode_builder/getdeps.py --allow-system-packages fixup-dyn-deps --strip --src-dir=. watchman _artifacts/linux --project-install-prefix watchman:/usr/local --final-install-prefix /usr/local

# Test Watchman
set +e  # Ensure all tests run even if some fail
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. watchman --project-install-prefix watchman:/usr/local