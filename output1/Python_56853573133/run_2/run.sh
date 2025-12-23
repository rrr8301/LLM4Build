#!/bin/bash

# Activate any necessary virtual environment (if using)
# source venv/bin/activate  # Uncomment if using virtualenv

# Install test dependencies
pip install pytest pytest-cov ruff

# Run linting
echo "Running lint checks..."
ruff check .

# Find and run all test files except those marked to skip in pytest.ini
echo "Running tests..."
if [ -f "matrix/tests/pytest.ini" ]; then
    # Use pytest.ini for configuration if it exists
    pytest -x -v --cov=. --durations=10 -c matrix/tests/pytest.ini matrix/tests/
else
    # Default test run if no pytest.ini
    pytest -x -v --cov=. --durations=10 matrix/tests/
fi

# Ensure exit code reflects test results
exit $?