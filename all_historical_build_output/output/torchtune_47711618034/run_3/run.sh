#!/bin/bash

# Activate the conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate test

# Run tests with coverage
pytest tests --ignore tests/torchtune/modules/_export --cov=. --cov-report=xml --durations=20 -vv

# Exit with the status of the pytest command
exit $?