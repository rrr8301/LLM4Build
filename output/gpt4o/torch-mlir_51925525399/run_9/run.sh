#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Install project dependencies
./build_tools/ci/install_python_deps.sh stable || echo "Warning: Some dependencies failed to install but continuing"

# Install torch-mlir if not already installed
pip install torch_mlir || echo "Warning: torch_mlir installation failed but continuing"

# Build the project
export cache_dir="/app/.container-cache"
bash build_tools/ci/build_posix.sh

# Run integration tests
set +e  # Continue on errors
bash build_tools/ci/test_posix.sh stable
test_exit_code=$?
set -e  # Stop on errors

# Check generated sources if torch-version is nightly
if [ "$1" == "nightly" ]; then
  bash build_tools/ci/check_generated_sources.sh
fi

exit $test_exit_code