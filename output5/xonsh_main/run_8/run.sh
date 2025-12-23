#!/bin/bash

set -e
set -o pipefail

# Activate the environment (if any specific activation is needed)
# source /path/to/venv/bin/activate

# Install project dependencies
python3.12 -m pip install -e ".[test]"

# Run tests with coverage
python3.12 -m xonsh run-tests.xsh test --report-coverage -- --timeout=240 || true

# Ensure all tests are executed, even if some fail