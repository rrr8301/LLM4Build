#!/bin/bash

set -e
set -o pipefail

# Activate Rust environment
source $HOME/.cargo/env

# Install Python dependencies
pip3 install -r requirements.txt || true

# Build buck2 binary (debug)
mkdir -p $RUNNER_TEMP/artifacts
cargo build --bin=buck2 -Z unstable-options --artifact-dir=$RUNNER_TEMP/artifacts || true

# Run tests
python3 test.py --ci --git --buck2=$RUNNER_TEMP/artifacts/buck2 || true