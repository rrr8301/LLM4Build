#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies (if any)
# No additional dependencies specified

# Run tests
set +e  # Ensure all tests run even if some fail
cargo build --locked
cargo test --locked --release --all-features --all-targets
cargo test --locked --release --all-features --doc
cargo test --locked --no-default-features --features aws-lc-rs,log,std --all-targets
cargo test --locked --release --no-default-features --features fips,log,std --all-targets
cargo build --locked --lib -p rustls $(admin/all-features-except std,brotli rustls)
cargo build --locked -p rustls-provider-example
cargo build --locked -p rustls-provider-example --no-default-features
cargo test --locked --all-features -p rustls-provider-example
cargo build --locked -p rustls-provider-test
cargo test --locked --all-features -p rustls-provider-test
cargo package --all-features -p rustls

# Exit with success
exit 0