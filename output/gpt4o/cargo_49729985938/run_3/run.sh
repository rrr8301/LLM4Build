#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Set default RUNNER_TEMP if not set
export RUNNER_TEMP=${RUNNER_TEMP:-/tmp}

# Dump environment
./ci/dump-environment.sh

# Run tests with error handling
function run_tests() {
    local cmd=$1
    local env_vars=("${@:2}")
    
    echo "Running: $cmd"
    echo "With env vars: ${env_vars[@]}"
    
    # Set environment variables if provided
    for var in "${env_vars[@]}"; do
        export "$var"
    done
    
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

# Run basic cargo tests
run_tests "cargo test -p cargo"

# Run git tests with gitoxide
run_tests "cargo test -p cargo git" "__CARGO_USE_GITOXIDE_INSTEAD_OF_GIT2=1"

# Run fix tests with argfile
run_tests "cargo test -p cargo --test testsuite -- fix::" "__CARGO_TEST_FORCE_ARGFILE=1"

# Run workspace tests (excluding specific packages)
run_tests "cargo test --workspace --exclude cargo --exclude benchsuite --exclude resolver-tests"

# Run benchmark tests
run_tests "cargo test -p benchsuite --all-targets -- cargo"
run_tests "cargo check -p capture"

# Fetch smoke test
./ci/fetch-smoke-test.sh

# Exit with error if any test failed
if [ $? -ne 0 ]; then
    exit 1
fi