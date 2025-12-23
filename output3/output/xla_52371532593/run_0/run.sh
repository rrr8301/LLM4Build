#!/bin/bash

# Activate Python environment if needed
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -e .

# Run tests
set +e  # Continue on errors
pytorch/xla/.github/scripts/run_tests.sh pytorch/ pytorch/xla/ $USE_COVERAGE

# Ensure all tests are executed
set -e