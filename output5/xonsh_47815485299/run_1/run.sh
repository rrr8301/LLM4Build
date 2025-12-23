#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Run tests
set +e  # Continue on errors
if [[ "$DEFAULT_PYTHON_VERSION" == "3.11" ]]; then
    python -m xonsh run-tests.xsh test --report-coverage -- --timeout=240
else
    python -m xonsh run-tests.xsh test -- --timeout=240
fi