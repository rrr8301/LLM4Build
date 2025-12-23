#!/bin/bash

# Activate conda environment if Python 3.14
if [[ "$(python --version)" == "Python 3.14"* ]]; then
    source /opt/conda/bin/activate
    conda activate base
fi

# Install project dependencies
uv pip install --system .

# Run tests with nox
nox --session "tests-3.11" -- --full-trace || true
nox --session "tests-3.14" -- --full-trace || true
nox --session minimums --force-python="3.11" -- --full-trace || true
nox --session minimums --force-python="3.14" -- --full-trace || true
nox --session "conda_tests" -- --full-trace || true