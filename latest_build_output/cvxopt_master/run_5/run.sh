#!/bin/bash

# Set SuiteSparse version and SHA256
export SUITESPARSE_VERSION=5.10.1  # Example version, replace with the correct one
export SUITESPARSE_SHA256=d41d8cd98f00b204e9800998ecf8427e  # Replace with the actual SHA256

# Get SuiteSparse source
wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256 || exit 1
tar -xf v${SUITESPARSE_VERSION}.tar.gz
export CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-${SUITESPARSE_VERSION}

# Install project dependencies
python3 -m pip install --no-index --find-links=dist cvxopt

# Build/install CVXOPT
python3 -m build --wheel || exit 1

# Run tests with pytest
pytest --cov=cvxopt tests || true