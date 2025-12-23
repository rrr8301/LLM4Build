#!/bin/bash

# Set SuiteSparse version and SHA256
export SUITESPARSE_VERSION=5.10.1  # Example version, replace with the correct one
export SUITESPARSE_SHA256=abc123...  # Example SHA256, replace with the correct one

# Install project dependencies
python3 -m pip install --no-index --find-links=dist cvxopt

# Get SuiteSparse source
wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256
tar -xf v${SUITESPARSE_VERSION}.tar.gz
export CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-${SUITESPARSE_VERSION}

# Build/install CVXOPT
python3 -m build --wheel

# Run tests with pytest
python3 -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests || true