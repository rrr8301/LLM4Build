#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is explicitly created

# Install project dependencies
python3.10 -m pip install --upgrade pip
pip install tox coverage

# Run tests
# Ensure the dist directory contains the necessary package artifacts
if [ -z "$USE_COVERAGE" ]; then
    tox run -e py310-xdist --installpkg `find dist/*.tar.gz` || true
else
    tox run -e py310-xdist-coverage --installpkg `find dist/*.tar.gz` || true
    python -m coverage xml || true
fi

# Ensure all tests are executed, even if some fail