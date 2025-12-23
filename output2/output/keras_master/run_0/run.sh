#!/bin/bash

# run.sh

# Activate the Python environment (if using venv, otherwise skip)
# source /path/to/venv/bin/activate

# Set environment variables
export KERAS_NNX_ENABLED=true

# Run tests and ensure all tests are executed
pytest keras/src/applications --cov=keras/src/applications --cov-config=pyproject.toml || true
coverage xml --include='keras/src/applications/*' -o apps-coverage.xml || true
python integration_tests/import_test.py || true
python integration_tests/basic_full_flow.py || true
python integration_tests/jax_custom_fit_test.py || true
pytest keras --ignore keras/src/applications --cov=keras --cov-config=pyproject.toml || true
coverage xml --omit='keras/src/applications/*,keras/api' -o core-coverage.xml || true

# Note: Uploading coverage to Codecov is not included due to unsupported action