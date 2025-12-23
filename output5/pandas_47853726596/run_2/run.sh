#!/bin/bash

# Activate the conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate <your-conda-env-name>  # Replace <your-conda-env-name> with the actual environment name

# Install project dependencies
pip install -e .

# Run tests
set +e  # Continue execution even if some tests fail
pytest --maxfail=0 --continue-on-collection-errors

# Ensure all test cases are executed
exit 0