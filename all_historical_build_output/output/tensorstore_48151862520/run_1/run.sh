#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Configure bazel remote cache
python ./tools/ci/configure_bazel_remote_cache.py --bazelrc ~/ci_bazelrc buildwheel-linux

# Build Python source distribution
python -m build --sdist

# Build Python wheels
python ./tools/ci/cibuildwheel.py --bazelrc ~/ci_bazelrc

# Ensure all tests are executed
set +e
# Placeholder for running tests
# Example: pytest tests/
set -e