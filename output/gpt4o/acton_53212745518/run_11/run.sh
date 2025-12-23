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
apt-get install -qy bzip2 curl g++ haskell-stack libtinfo-dev make procps zlib1g-dev gdb libgmp-dev libffi-dev libncurses-dev libgirepository1.0-dev gobject-introspection libc6-dev ca-certificates qemu-user-static

# Install cross-compilation tools separately
apt-get install -qy gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Install multilib tools separately
apt-get install -qy gcc-multilib g++-multilib clang lld llvm mingw-w64

# Ensure UTF-8 locale is properly set
apt-get install -qy locales
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
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

# Run tests with more verbosity and save detailed output
TEST_OUTPUT=$(mktemp)
TEST_LOG_DIR=/app/test-logs
mkdir -p $TEST_LOG_DIR

echo "Running tests with detailed logging..."
if ! make -C /app test > "$TEST_OUTPUT" 2>&1; then
    echo "Tests failed, preserving test output"
    cat "$TEST_OUTPUT"
    
    # Save individual test logs
    if [ -d "/app/test" ]; then
        find /app/test -name "*.log" -exec cp {} $TEST_LOG_DIR \;
    fi
    
    # Save core dumps if any
    if [ -d "/app" ]; then
        find /app -name "core.*" -exec cp {} $TEST_LOG_DIR \;
    fi
    
    echo "Test logs and core dumps saved in $TEST_LOG_DIR"
    ls -la $TEST_LOG_DIR
    
    exit 1
fi

echo "All tests passed successfully"