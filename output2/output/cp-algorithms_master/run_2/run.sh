#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Install project dependencies if requirements.txt exists
if [ -f requirements.txt ]; then
    python3 -m pip install -r requirements.txt
fi

# Run tests and build documentation
set +e  # Continue execution even if some tests fail
if [ -f ./test/test.sh ]; then
    ./test/test.sh
fi
mkdocs build --strict
set -e  # Re-enable exit on error