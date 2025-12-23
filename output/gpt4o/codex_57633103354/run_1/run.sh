#!/bin/bash

set -euo pipefail

# Activate Rust environment
source $HOME/.cargo/env

# Remove unnecessary dependencies
sudo rm -rf /usr/local/lib/android /usr/share/dotnet /usr/local/share/boost /usr/local/lib/node_modules /opt/ghc
sudo apt-get remove -y docker.io docker-compose podman buildah

# Compute lockfile hash
LOCK_HASH=$(sha256sum codex-rs/Cargo.lock | cut -d' ' -f1)
TOOLCHAIN_HASH=$(sha256sum codex-rs/rust-toolchain.toml | cut -d' ' -f1)

# Set environment variables
export RUSTC_WRAPPER=sccache
export RUST_BACKTRACE=1
export NEXTEST_STATUS_LEVEL=leak

# Run tests
cd codex-rs
cargo nextest run --all-features --no-fail-fast --target x86_64-unknown-linux-gnu --cargo-profile ci-test || true