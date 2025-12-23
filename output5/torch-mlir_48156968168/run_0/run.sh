#!/bin/bash

set -e

# Activate Python virtual environment
python3.11 -m venv mlir_venv
source mlir_venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install project dependencies
bash build_tools/ci/install_python_deps.sh stable

# Build the project
bash build_tools/ci/build_posix.sh

# Run integration tests
set +e  # Ensure all tests run even if some fail
bash build_tools/ci/test_posix.sh stable
set -e

# Check generated sources for torch-nightly
if [ "$TORCH_VERSION" == "nightly" ]; then
  bash build_tools/ci/check_generated_sources.sh
fi