#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Install project dependencies
python3 -m pip install -r requirements.txt

# Run tests and build documentation
set +e  # Continue execution even if some tests fail
./test/test.sh
mkdocs build --strict
set -e  # Re-enable exit on error