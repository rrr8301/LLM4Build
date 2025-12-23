#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Set default RUNNER_TEMP if not set
export RUNNER_TEMP=${RUNNER_TEMP:-/tmp}

# Dump environment
./ci/dump-environment.sh

# Configure extra test environment
export CARGO_CONTAINER_TESTS=1

# Run tests with error handling
function run_tests() {
    local cmd=$1
    echo "Running: $cmd"
    $cmd
    local status=$?
    if [ $status -ne 0 ]; then
        echo "Error: Command failed with exit status $status"
        return $status
    fi
    ./ci/clean-test-output.sh
    return 0
}

# Run tests in sequence
set +e  # Continue on errors

run_tests "cargo test -p cargo"
run_tests "cargo test -p cargo git"
run_tests "cargo test -p cargo --test testsuite -- fix::"
run_tests "cargo test --workspace --exclude cargo --exclude benchsuite --exclude resolver-tests"
run_tests "cargo test -p benchsuite --all-targets -- cargo"
run_tests "cargo check -p capture"

# Run gitoxide tests separately with its own environment
export __CARGO_USE_GITOXIDE_INSTEAD_OF_GIT2=1
run_tests "cargo test -p cargo git"
export __CARGO_TEST_FORCE_ARGFILE=1
run_tests "cargo test -p cargo --test testsuite -- fix::"

# Fetch smoke test
./ci/fetch-smoke-test.sh

# Exit with error if any test failed
if [ $? -ne 0 ]; then
    exit 1
fi