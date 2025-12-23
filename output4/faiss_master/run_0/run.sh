#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Run tests
pytest --junitxml=test-results/results.xml || true

# Ensure all tests are executed, even if some fail
exit 0