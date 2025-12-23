#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies
uv sync --extra all --extra testing --extra docs

# Install JAX and JAXlib
uv pip install "jax==0.6.0" "jaxlib==0.6.0"

# Install additional test dependencies
uv pip install -U tensorflow-datasets

# Run tests
set +e  # Continue on errors
uv run tests/run_all_tests.sh --only-pytest
set -e  # Stop on errors