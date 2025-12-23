#!/bin/bash

# Activate Python environment (if any)
# Assuming system Python is used, no virtualenv activation needed

# Sync dependencies with UV
uv sync --group=test

# Run tests with pytest, ensuring all tests are executed
set +e  # Do not exit immediately on error
uv run pytest \
  --cov-report=term-missing:skip-covered \
  --cov=. .
set -e  # Re-enable exit on error

# If tests are successful, build the directory markdown
if [ $? -eq 0 ]; then
  python3 scripts/build_directory_md.py 2>&1 | tee DIRECTORY.md
fi