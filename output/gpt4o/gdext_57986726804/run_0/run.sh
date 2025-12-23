#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Patch Cargo.toml if necessary
if [ "$(uname)" == "Linux" ]; then
    .github/other/patch-prebuilt.sh nightly
fi

# Install minimal dependency versions if required
if [ "$1" == "-minimal-deps" ]; then
    cargo +nightly update -Z minimal-versions
fi

# Compile tests
cargo test $TEST_FEATURES --no-run

# Run tests, ensuring all tests are executed
set +e
cargo test $TEST_FEATURES
set -e