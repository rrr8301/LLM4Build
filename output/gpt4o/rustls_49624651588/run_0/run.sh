#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
# (Assuming dependencies are managed by Cargo.toml)
cargo fetch

# Run tests
set -e
cargo build --locked
cargo test --release --locked --all-features --all-targets || true
cargo test --release --locked --all-features --doc || true
cargo test --no-default-features --features aws-lc-rs,log,std --all-targets || true
cargo test --release --no-default-features --features fips,log,std --all-targets || true
cargo build --locked --lib -p rustls $(admin/all-features-except std,brotli rustls) || true
cargo build --locked -p rustls-provider-example || true
cargo build --locked -p rustls-provider-example --no-default-features || true
cargo test --all-features -p rustls-provider-example || true
cargo build --locked -p rustls-provider-test || true
cargo test --all-features -p rustls-provider-test || true
cargo package --all-features -p rustls || true