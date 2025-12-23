#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Install project in development mode (for Python components)
pip install -e .

# Build Rust components
cargo build --release

# Run Rust tests
echo "Running Rust tests..."
cargo test --release || true  # Continue even if tests fail

# Run Python tests (if any)
echo "Running Python tests..."
python -m pytest || true  # Continue even if tests fail

# Run any additional test scripts
if [ -f "scripts/packages/built-by-uv/test.sh" ]; then
    echo "Running built-by-uv tests..."
    bash scripts/packages/built-by-uv/test.sh || true
fi

# Run benchmarks if they exist
if [ -f "scripts/benchmark/uv.lock" ]; then
    echo "Running benchmarks..."
    uv pip sync scripts/benchmark/uv.lock || true
fi

echo "All test phases completed"