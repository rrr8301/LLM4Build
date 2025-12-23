#!/bin/bash
set -e

# Environment variable from GitHub Actions
export PYTEST_ADDOPTS="--color=yes"

# Assume dist/*.tar.gz exists; if not, skip --installpkg
PACKAGE_TAR=$(find dist/*.tar.gz 2>/dev/null || true)

if [ -n "$PACKAGE_TAR" ]; then
    echo "Running tests with coverage and installing package from $PACKAGE_TAR"
    tox run -e py312-coverage --installpkg "$PACKAGE_TAR"
else
    echo "No package tarball found in dist/, running tests without --installpkg"
    tox run -e py312-coverage
fi

# Generate coverage report
python -m coverage xml

echo "Test run and coverage report generation completed."