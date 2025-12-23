#!/bin/bash

# Activate the micromamba environment
source /usr/local/bin/micromamba shell init -s bash
micromamba activate pymc-test

# Install project dependencies
pip install -e .

# Run tests
set +e  # Continue on errors
python -m pytest -vv --cov=pymc --cov-report=xml --no-cov-on-fail --cov-report term --durations=50 $TEST_SUBSET