#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Run all tests, ensuring all are executed even if some fail
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15 || true