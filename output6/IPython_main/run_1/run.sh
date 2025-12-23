#!/bin/bash

# Activate virtual environment if needed (not used here as system Python is used)

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python3.12 -m build
pytest --color=yes -raXxs --cov --cov-report=xml --maxfail=15

# Generate coverage XML
coverage combine `find . -name .coverage\*` && coverage xml

# Note: Uploading to Codecov is not automated here. Please upload coverage.xml manually.
echo "Please upload coverage.xml to Codecov manually."