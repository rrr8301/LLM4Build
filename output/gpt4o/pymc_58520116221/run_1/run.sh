#!/bin/bash

# Initialize micromamba shell
eval "$(micromamba shell hook --shell bash)"

# Activate micromamba environment and run commands
micromamba run -n pymc-test /bin/bash -c "
    # Install project dependencies
    pip install -e .

    # Run tests
    set +e  # Continue on error
    python -m pytest -vv --cov=pymc --cov-report=xml --no-cov-on-fail --cov-report term --durations=50 $TEST_SUBSET
"