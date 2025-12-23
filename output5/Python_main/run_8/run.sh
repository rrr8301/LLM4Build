#!/bin/bash

# Run tests
echo "Running doctests..."
# Ensure my_submission.py is present in the current directory
if [ ! -f my_submission.py ]; then
    echo "Error: my_submission.py not found!"
    exit 1
fi
python3 -m doctest -v my_submission.py || exit 1  # Exit on failure

echo "Running ruff checks..."
ruff check || exit 1  # Exit on failure

echo "Running pytest..."
pytest --cov-report=term-missing \
       --cov=. \
       --continue \
       -Denforcer.skip=true \
       -Drat.skip=true || exit 1  # Exit on failure

echo "Running mypy checks..."
mypy --ignore-missing-imports . || exit 1  # Exit on failure