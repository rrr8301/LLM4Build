#!/bin/bash

set -e

# Activate Python virtual environment
python3.11 -m venv mlir_venv
source mlir_venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install project dependencies
if [ -f "build_tools/ci/install_python_deps.sh" ]; then
    bash build_tools/ci/install_python_deps.sh stable
else
    echo "Warning: install_python_deps.sh not found. Skipping dependency installation."
fi

# Set environment variables for CMake to use clang and lld
export CC=clang
export CXX=clang++
export CMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld"

# Build the project
if [ -f "build_tools/ci/build_posix.sh" ]; then
    bash build_tools/ci/build_posix.sh
else
    echo "Warning: build_posix.sh not found. Skipping build step."
fi

# Run integration tests
set +e  # Ensure all tests run even if some fail
if [ -f "build_tools/ci/test_posix.sh" ]; then
    bash build_tools/ci/test_posix.sh stable
else
    echo "Warning: test_posix.sh not found. Skipping tests."
fi
set -e

# Check generated sources for torch-nightly
if [ "$TORCH_VERSION" == "nightly" ]; then
    if [ -f "build_tools/ci/check_generated_sources.sh" ]; then
        bash build_tools/ci/check_generated_sources.sh
    else
        echo "Warning: check_generated_sources.sh not found. Skipping source check."
    fi
fi