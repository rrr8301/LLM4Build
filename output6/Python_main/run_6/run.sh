#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Sync with uv
uv sync --group=test

# Run tests with pytest, ensuring all tests are executed
set +e
uv run pytest \
  --cov-report=term-missing:skip-covered \
  --cov=. .
TEST_EXIT_CODE=$?

# If tests are successful, build the directory markdown
if [ $TEST_EXIT_CODE -eq 0 ]; then
  python scripts/build_directory_md.py 2>&1 | tee DIRECTORY.md
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE