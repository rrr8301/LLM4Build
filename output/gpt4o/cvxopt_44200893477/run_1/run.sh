#!/bin/bash

# Activate Python environment
python3.9 -m venv /venv
source /venv/bin/activate

# Install project dependencies
pip install .

# Get SuiteSparse source
wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256 || exit 1
tar -xf v${SUITESPARSE_VERSION}.tar.gz
export CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-${SUITESPARSE_VERSION}

# Build and install CVXOPT
python -m build --wheel
pip install --no-index --find-links=dist cvxopt

# Run tests
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw" || exit 1
pytest --cov=cvxopt tests || true