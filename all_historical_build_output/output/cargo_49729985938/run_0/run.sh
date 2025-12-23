# run.sh
#!/bin/bash

set -e
set -o pipefail

# Dump environment
ci/dump-environment.sh

# Configure extra test environment
export CARGO_CONTAINER_TESTS=1

# Run tests
cargo test -p cargo || true
ci/clean-test-output.sh

# Run gitoxide tests
export __CARGO_USE_GITOXIDE_INSTEAD_OF_GIT2=1
cargo test -p cargo git || true
ci/clean-test-output.sh

# Check operability of rustc invocation with argfile
export __CARGO_TEST_FORCE_ARGFILE=1
cargo test -p cargo --test testsuite -- fix:: || true

# Run workspace tests excluding certain packages
cargo test --workspace --exclude cargo --exclude benchsuite --exclude resolver-tests || true

# Check benchmarks
cargo test -p benchsuite --all-targets -- cargo || true
cargo check -p capture || true
ci/clean-test-output.sh

# Fetch smoke test
ci/fetch-smoke-test.sh || true