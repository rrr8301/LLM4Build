#!/bin/bash

# Activate virtual environment
source /venv/bin/activate

# Run tests with coverage
set +e  # Continue on errors
python -m pytest -v --cov=memray --cov-report=xml