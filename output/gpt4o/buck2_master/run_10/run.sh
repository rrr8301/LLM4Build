#!/bin/bash

# Activate the virtual environment
source /venv/bin/activate

# Install project dependencies (in case requirements changed)
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Ensure Rust toolchain is up to date
rustup update nightly-2025-09-14
rustup default nightly-2025-09-14

# Clean any existing build artifacts
cargo clean

# Update cargo dependencies
cargo update

# Build without the oid feature as it's not available
cargo build --release

# Run tests
# Ensure all tests are executed, even if some fail
set +e
python test.py --ci --git --buck2=/path/to/simulated/artifacts/buck2
EXIT_CODE=$?
set -e

exit $EXIT_CODE