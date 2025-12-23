#!/bin/bash

# Activate the Python environment
source /app/venv/bin/activate

# Set the backend environment variable
export KERAS_BACKEND="jax"

# Run integration tests if backend is not numpy
if [ "$KERAS_BACKEND" != "numpy" ]; then
    python integration_tests/import_test.py || true
fi

# Run tests with pytest
pytest keras --ignore keras/src/applications --cov=keras --cov-config=pyproject.toml || true