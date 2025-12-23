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

./build_tools/ci/install_python_deps.sh stable

# Build the project
export cache_dir="/workspace/.container-cache"
bash build_tools/ci/build_posix.sh

# Run integration tests
set +e  # Ensure all tests run even if some fail
bash build_tools/ci/test_posix.sh stable