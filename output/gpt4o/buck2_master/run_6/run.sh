#!/bin/bash

# Activate the virtual environment
source /venv/bin/activate

# Install project dependencies (in case requirements changed)
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Ensure Rust toolchain is up to date
rustup update

# Run tests
# Ensure all tests are executed, even if some fail
set +e
python test.py --ci --git --buck2=/path/to/simulated/artifacts/buck2
EXIT_CODE=$?
set -e

exit $EXIT_CODE