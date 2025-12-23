#!/bin/bash

# Run tests
echo "Running doctests..."
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