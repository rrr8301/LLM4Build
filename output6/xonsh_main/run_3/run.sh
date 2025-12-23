#!/bin/bash

# run.sh

# Activate the virtual environment
source venv/bin/activate

# Run tests with coverage
set +e  # Continue executing even if some tests fail
pytest --timeout=240 --cov --cov-report=xml --cov-report=term