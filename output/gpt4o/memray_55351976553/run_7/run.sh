#!/bin/bash

# Activate virtual environment
source /venv/bin/activate

# Run tests with coverage
set +e  # Continue on errors
make pycoverage