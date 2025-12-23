#!/bin/bash

set -e

# Activate Python virtual environment
source /opt/mlir_venv/bin/activate

# Install project dependencies
cd /workspace

# Check if the requirements file exists, if not, create a placeholder or correct the path
if [ ! -f "./externals/llvm-project/mlir/python/requirements.txt" ]; then
    echo "requirements.txt not found, creating a placeholder."
    mkdir -p ./externals/llvm-project/mlir/python
    touch ./externals/llvm-project/mlir/python/requirements.txt
fi

# Ensure the llvm-project directory exists
if [ ! -d "./externals/llvm-project/llvm" ]; then
    echo "Cloning llvm-project repository..."
    rm -rf ./externals/llvm-project  # Remove the existing directory if it exists
    git clone --depth 1 https://github.com/llvm/llvm-project.git ./externals/llvm-project
fi

# Set the CC and CXX environment variables to use clang
export CC=clang
export CXX=clang++

# Set the linker to lld
export LD=lld

./build_tools/ci/install_python_deps.sh stable

# Build the project
export cache_dir="/workspace/.container-cache"
bash build_tools/ci/build_posix.sh

# Run integration tests
set +e  # Ensure all tests run even if some fail
bash build_tools/ci/test_posix.sh stable