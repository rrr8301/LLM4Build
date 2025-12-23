#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Run tests with tox, ensuring all tests are executed
set +e  # Do not exit immediately on failure
uv run --locked tox run -e py3.11
EXIT_CODE=$?

# Exit with the test command's exit code
exit $EXIT_CODE