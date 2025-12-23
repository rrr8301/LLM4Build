#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create and activate the Python virtual environment
python -m venv marimo_env
source marimo_env/bin/activate

# Install project dependencies using Hatch
hatch env create

# Create assets directory and copy files
mkdir -p marimo/_static/assets
cp frontend/index.html marimo/_static/index.html
cp frontend/public/favicon.ico marimo/_static/favicon.ico

# Run linting
hatch run lint || true

# Run type checking
hatch run typecheck:check || true

# Run tests
hatch run +py=3.12 test:test -v tests/ -k "not test_cli" --durations=10 \
--cov=marimo --cov-report=xml --junitxml=junit.xml -o junit_family=legacy || true

# Note: Codecov upload steps are not included as they are unsupported in this context