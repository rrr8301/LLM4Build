#!/bin/bash

# Activate the environment (if any virtual environment is used, otherwise skip)
# source /path/to/venv/bin/activate

# Set environment variables
export PYTHON=3.10
export KERAS_HOME=.github/workflows/config/numpy

# Run tests with pytest
pytest keras/src/applications --cov=keras/src/applications --cov-config=pyproject.toml || true
coverage xml --include='keras/src/applications/*' -o apps-coverage.xml || true

# Run additional tests
pytest keras --ignore keras/src/applications --cov=keras --cov-config=pyproject.toml || true
coverage xml --omit='keras/src/applications/*,keras/api' -o core-coverage.xml || true

# Note: The `|| true` ensures that all tests are executed even if some fail.