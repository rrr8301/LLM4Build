#!/bin/bash

# Activate the virtual environment
source /opt/venv/bin/activate

# Build NumPy
spin build --clean

# Run tests
set +e  # Continue execution even if some tests fail
spin test -- --timeout=600 --durations=10