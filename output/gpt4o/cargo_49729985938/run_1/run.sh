#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Dump environment
./ci/dump-environment.sh

# Configure extra test environment
export CARGO_CONTAINER_TESTS=1

# Run tests
set +e  # Continue on errors
cargo test -p cargo
./ci/clean-test-output.sh

# Run gitoxide tests
export __CARGO_USE_GITOXIDE_INSTEAD_OF_GIT2=1
cargo test -p cargo git
./ci/clean-test-output.sh

# Check operability of rustc invocation with argfile
export __CARGO_TEST_FORCE_ARGFILE=1
cargo test -p cargo --test testsuite -- fix::
./ci/clean-test-output.sh

# Run workspace tests excluding certain packages
cargo test --workspace --exclude cargo --exclude benchsuite --exclude resolver-tests
./ci/clean-test-output.sh

# Check benchmarks
cargo test -p benchsuite --all-targets -- cargo
cargo check -p capture
./ci/clean-test-output.sh

# Fetch smoke test
./ci/fetch-smoke-test.sh

# Ensure all tests are executed
set -e