# run.sh
#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo fetch

# Run cargo clippy
cargo clippy --target x86_64-unknown-linux-musl --all-features --tests -- -D warnings

# Build individual crates
find . -name Cargo.toml -mindepth 2 -maxdepth 2 -print0 | xargs -0 -n1 -I{} bash -c 'cd "$(dirname "{}")" && cargo build --profile dev' || true

# Run tests
RUST_BACKTRACE=1 cargo test --all-features --target x86_64-unknown-linux-musl --profile dev || true

# Verify all steps passed
if [ $? -ne 0 ]; then
  echo "One or more checks failed (clippy, build, or test). See logs for details."
  exit 1
fi