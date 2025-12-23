#!/bin/bash

# Show platform and environment
uname -a
env
cat /proc/cpuinfo

# Set BUILD_RELEASE if building for a version tag
if [[ "$GITHUB_REF" == refs/tags/v* ]]; then
  export BUILD_RELEASE=1
fi

# Create test output directory early
TEST_LOG_DIR=/app/test-logs
mkdir -p $TEST_LOG_DIR

# Build Acton with more verbose output
echo "Building Acton..."
if ! make -j2 -C /app BUILD_RELEASE=${BUILD_RELEASE} > "$TEST_LOG_DIR/build_output.log" 2>&1; then
    echo "Build failed, preserving build output"
    cat "$TEST_LOG_DIR/build_output.log"
    exit 1
fi

# Build release
echo "Building release..."
if ! make -C /app release >> "$TEST_LOG_DIR/build_output.log" 2>&1; then
    echo "Release build failed, preserving build output"
    cat "$TEST_LOG_DIR/build_output.log"
    exit 1
fi

# Run tests with proper UTF-8 environment
ulimit -c unlimited
export GHC_CHARENC='UTF-8'

# Initialize stack and install dependencies if needed
if [ ! -f "/app/stack.yaml" ]; then
    echo "Generating stack.yaml..."
    stack init --force --resolver=lts-21.22
fi

echo "Setting up stack..."
stack setup > "$TEST_LOG_DIR/stack_setup.log" 2>&1

# Only try to build dependencies if there are local packages
if [ -f "/app/package.yaml" ] || [ -f "/app/*.cabal" ]; then
    echo "Building dependencies..."
    stack build --only-dependencies > "$TEST_LOG_DIR/deps_build.log" 2>&1
fi

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
        echo "=== Build logs ==="
        cat "$TEST_LOG_DIR/build_output.log"
        echo "=== Stack setup logs ==="
        cat "$TEST_LOG_DIR/stack_setup.log"
        echo "=== Dependencies build logs ==="
        cat "$TEST_LOG_DIR/deps_build.log"
    } > "$TEST_LOG_DIR/debug_info.log"
    
    echo "Test logs and debug information saved in $TEST_LOG_DIR"
    ls -la $TEST_LOG_DIR
    
    # Exit with error to fail the build
    exit 1
fi

echo "All tests passed successfully"