#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Initialize submodules (just in case)
if [ -d .git ]; then
    git submodule update --init --recursive || echo "Warning: Submodule update failed but continuing"
fi

# Install project dependencies
set +e  # Continue on errors
./build_tools/ci/install_python_deps.sh stable || echo "Warning: Some dependencies failed to install but continuing"
set -e  # Stop on errors

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