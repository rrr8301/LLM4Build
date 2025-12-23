#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is used, as tox handles environments

# Install project dependencies
# Assuming dependencies are managed by tox

# Run tests with coverage
tox run -e py311-coverage --installpkg `find dist/*.tar.gz`

# Generate coverage report
python3.11 -m coverage xml

# Note: Codecov upload is ignored as it's an unsupported action