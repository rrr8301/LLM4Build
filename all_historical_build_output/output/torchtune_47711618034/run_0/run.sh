#!/bin/bash

# Activate the conda environment
source /opt/conda/bin/activate test

# Run tests with coverage
pytest tests --ignore tests/torchtune/modules/_export --cov=. --cov-report=xml --durations=20 -vv || true

# Ensure all tests are executed even if some fail
exit 0