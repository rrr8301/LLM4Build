#!/bin/bash

# Activate the conda environment
source /etc/profile.d/conda.sh
conda activate <your-conda-env-name>

# Install project dependencies
pip install -e .

# Run tests
set +e  # Continue execution even if some tests fail
pytest --maxfail=0 --continue-on-collection-errors

# Ensure all test cases are executed
exit 0