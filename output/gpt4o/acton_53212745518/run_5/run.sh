#!/bin/bash

# Show platform and environment
uname -a
env
cat /proc/cpuinfo

# Set BUILD_RELEASE if building for a version tag
if [[ "$GITHUB_REF" == refs/tags/v* ]]; then
  export BUILD_RELEASE=1
fi

# Install build prerequisites
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -qy bzip2 curl g++ haskell-stack libtinfo-dev make procps zlib1g-dev gdb libgmp-dev libffi-dev libncurses-dev libgirepository1.0-dev gobject-introspection libc6-dev

# Ensure UTF-8 locale is properly set
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Build Acton
make -j2 -C /app BUILD_RELEASE=${BUILD_RELEASE}

# Build a release
make -C /app release

# Run tests with proper UTF-8 environment
ulimit -c unlimited
export GHC_CHARENC='UTF-8'

# Initialize stack and install dependencies
stack setup
stack build --only-dependencies

# Run tests with more verbosity and don't exit on first failure
# Capture test output and preserve it if tests fail
TEST_OUTPUT=$(mktemp)
if ! make -C /app test > "$TEST_OUTPUT" 2>&1; then
    echo "Tests failed, preserving test output"
    cat "$TEST_OUTPUT"
    # Run individual test suites with more verbosity
    (cd /app && stack test --test-arguments="--rerun --show-details=streaming" || true)
    # Try to run specific test suites if the main test target fails
    (cd /app/compiler && stack test actonc --test-arguments="--rerun --show-details=streaming" || true)
    exit 1
fi