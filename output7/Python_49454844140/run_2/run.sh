#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies
if [ -f requirements.txt ]; then
  pip install -r requirements.txt
fi

# Sync dependencies using uv
uv sync --group=test

# Run tests with pytest, ensuring all tests are executed
set +e  # Do not exit immediately on error
pytest \
  --cov-report=term-missing:skip-covered \
  --cov=. .
TEST_EXIT_CODE=$?

# If tests succeed, build the directory markdown
if [ $TEST_EXIT_CODE -eq 0 ]; then
  if [ -f scripts/build_directory_md.py ]; then
    python3 scripts/build_directory_md.py 2>&1 | tee DIRECTORY.md
  else
    echo "Warning: scripts/build_directory_md.py not found."
  fi
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE