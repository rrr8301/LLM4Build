#!/bin/bash

set -e

# Activate Python virtual environment
source /opt/mlir_venv/bin/activate

# Install project dependencies
cd /workspace
./build_tools/ci/install_python_deps.sh stable

# Build the project
export cache_dir="/workspace/.container-cache"
bash build_tools/ci/build_posix.sh

# Run integration tests
set +e  # Ensure all tests run even if some fail
bash build_tools/ci/test_posix.sh stable