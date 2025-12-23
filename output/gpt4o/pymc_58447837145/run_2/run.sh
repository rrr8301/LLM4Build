#!/bin/bash

# Initialize micromamba shell
eval "$(micromamba shell hook --shell bash)"

# Activate the micromamba environment
micromamba activate pymc-test

# Install project dependencies
micromamba run -n pymc-test pip install -e .

# Run tests
set +e  # Continue on errors
micromamba run -n pymc-test python -m pytest -vv \
    --cov=pymc \
    --cov-report=xml \
    --no-cov-on-fail \
    --cov-report term \
    --durations=50 \
    $TEST_SUBSET