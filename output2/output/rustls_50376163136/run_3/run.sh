#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# Assuming no additional dependencies are needed beyond Rust toolchain

# Run tests
set +e  # Ensure all tests run even if some fail
cargo build --locked
cargo test --release --locked --all-features --all-targets
cargo test --release --locked --all-features --doc
cargo test --no-default-features --features aws-lc-rs,log,std --all-targets
cargo test --release --no-default-features --features fips,log,std --all-targets
cargo build --locked --lib -p rustls $(admin/all-features-except std,brotli rustls)
cargo build --locked -p rustls-provider-example
cargo build --locked -p rustls-provider-example --no-default-features
cargo test --all-features -p rustls-provider-example
cargo build --locked -p rustls-provider-test
cargo test --all-features -p rustls-provider-test
cargo package --all-features -p rustls

# Exit with the last command's exit code
exit $?