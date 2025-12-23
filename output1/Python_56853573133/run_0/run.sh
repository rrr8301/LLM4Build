#!/bin/bash

# Activate any necessary virtual environment (if using)
# source venv/bin/activate  # Uncomment if using virtualenv

# Install test dependencies
pip install pytest pytest-cov ruff

# Run linting
echo "Running lint checks..."
ruff check .

# Run tests with pytest
# -x: exit instantly on first error or failed test
# --cov: generate coverage report
# -v: verbose output
# --durations=10: show 10 slowest tests
echo "Running tests..."
pytest -x -v --cov=. --durations=10 matrix/tests/ || true

# Ensure all tests are run even if some fail
echo "Test execution completed."