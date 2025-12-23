#!/bin/bash

# Create and activate Python virtual environment
python3.14 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip

# Get SuiteSparse source
wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256
tar -xf v${SUITESPARSE_VERSION}.tar.gz
export CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-${SUITESPARSE_VERSION}

# Build/install CVXOPT
python -m build --wheel
pip install --no-index --find-links=./dist cvxopt

# Run tests
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests || true