#!/bin/bash

# Load pyenv into the shell
export PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Activate virtual environment if needed
# source .venv/bin/activate

# Install project dependencies
python scripts/ci/install

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python scripts/ci/run-tests --with-cov --with-xdist
set -e  # Re-enable exit on error