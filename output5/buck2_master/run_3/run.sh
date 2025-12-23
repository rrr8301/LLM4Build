#!/bin/bash

# Create and activate a Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Set environment variables for tests
export RUNNER_TEMP=/tmp/runner
mkdir -p $RUNNER_TEMP/artifacts

# Build Rust binary
cargo build --bin=buck2 -Z unstable-options --artifact-dir=$RUNNER_TEMP/artifacts

# Run tests
set +e  # Continue executing even if some tests fail
RUST_BACKTRACE=1 python3 test.py --ci --git --buck2=$RUNNER_TEMP/artifacts/buck2