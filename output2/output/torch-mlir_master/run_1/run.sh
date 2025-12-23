#!/bin/bash

# Activate virtual environment if needed
# source /path/to/venv/bin/activate

# Build the project
bash build_tools/ci/build_posix.sh

# Run tests
set +e  # Continue execution even if some tests fail
bash build_tools/ci/test_posix.sh stable
set -e