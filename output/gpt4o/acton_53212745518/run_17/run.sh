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

# Build Acton
make -j2 -C /app BUILD_RELEASE=${BUILD_RELEASE}

# Build a release
make -C /app release

# Run tests with proper UTF-8 environment
ulimit -c unlimited
export GHC_CHARENC='UTF-8'

# Initialize stack and install dependencies
if [ ! -f "/app/stack.yaml" ]; then
    echo "Generating stack.yaml..."
    stack init --force --resolver=lts-21.22
fi

stack setup
stack build --only-dependencies

# Create test output directory
TEST_LOG_DIR=/app/test-logs
mkdir -p $TEST_LOG_DIR

# Run tests with more verbosity and save detailed output
echo "Running tests with detailed logging..."
if ! make -C /app test > "$TEST_LOG_DIR/test_output.log" 2>&1; then
    echo "Tests failed, preserving test output"
    cat "$TEST_LOG_DIR/test_output.log"
    
    # Save individual test logs
    if [ -d "/app/test" ]; then
        find /app/test -name "*.log" -exec cp -v {} $TEST_LOG_DIR \;
    fi
    
    # Save core dumps if any
    if [ -d "/app" ]; then
        find /app -name "core.*" -exec cp -v {} $TEST_LOG_DIR \;
    fi
    
    # Save stack logs
    if [ -d "/root/.stack" ]; then
        mkdir -p $TEST_LOG_DIR/stack_logs
        cp -rv /root/.stack/logs/* $TEST_LOG_DIR/stack_logs/ || true
    fi
    
    # Save additional debug information
    {
        echo "=== Stack version ==="
        stack --version
        echo "=== GHC version ==="
        stack ghc -- --version
        echo "=== Installed packages ==="
        stack ls dependencies
        echo "=== Test directory contents ==="
        ls -la /app/test
        echo "=== Core dump info ==="
        if [ -f "$TEST_LOG_DIR/core.c" ]; then
            gdb -batch -ex "file /app/compiler/actonc" -ex "core-file $TEST_LOG_DIR/core.c" -ex "bt full"
        fi
    } > "$TEST_LOG_DIR/debug_info.log"
    
    echo "Test logs and debug information saved in $TEST_LOG_DIR"
    ls -la $TEST_LOG_DIR
    
    # Exit with error to fail the build
    exit 1
fi

echo "All tests passed successfully"