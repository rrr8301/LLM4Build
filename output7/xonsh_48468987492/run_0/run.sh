#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Run tests
if [[ "$DEFAULT_PYTHON_VERSION" == "3.13" ]]; then
    python -m xonsh run-tests.xsh test --report-coverage -- --timeout=240 || true
else
    python -m xonsh run-tests.xsh test -- --timeout=240 || true
fi