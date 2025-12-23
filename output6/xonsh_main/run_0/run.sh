#!/bin/bash

# run.sh

# Activate the virtual environment
source venv/bin/activate

# Run tests with coverage
set +e  # Continue executing even if some tests fail
python -m xonsh run-tests.xsh test --report-coverage -- --timeout=240