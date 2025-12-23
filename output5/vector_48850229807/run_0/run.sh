#!/bin/bash

# Activate Python environment
source /usr/bin/python3.11

# Install project dependencies
pip install -e .

# Run doctests
nox -s doctests-3.11 --verbose || true

# Run tests and generate coverage report
nox -s coverage-3.11 --verbose || true

# Note: Uploading coverage report is not automated in this script.
# Please manually upload the coverage report to Codecov using the following command:
# curl -s https://codecov.io/bash | bash -s -- -t <CODECOV_TOKEN>