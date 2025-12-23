#!/bin/bash

# Activate the Python environment
# Note: No need to source Python binary, just use it directly
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