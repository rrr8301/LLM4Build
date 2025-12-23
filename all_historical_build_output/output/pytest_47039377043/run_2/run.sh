#!/bin/bash
set -euo pipefail

# Optional environment variable to control coverage usage
USE_COVERAGE=${USE_COVERAGE:-false}

# Upgrade pip and install tox and coverage (redundant but ensures latest)
python -m pip install --upgrade pip
pip install tox coverage

# Find the package in dist directory
PKG=$(find dist -maxdepth 1 -name '*.tar.gz' | head -n 1 || true)

if [[ -z "$PKG" ]]; then
  echo "No package found in dist/*.tar.gz"
  exit 1
fi

if [[ "$USE_COVERAGE" == "true" ]]; then
  echo "Running tests with coverage enabled"
  tox -e py39-xdist-coverage --installpkg "$PKG"
  echo "Generating coverage report"
  python -m coverage xml
else
  echo "Running tests without coverage"
  tox -e py39-xdist --installpkg "$PKG"
fi

echo "Test run completed."