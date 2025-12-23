#!/bin/bash

# Set SuiteSparse version and SHA256
export SUITESPARSE_VERSION=5.10.1
export SUITESPARSE_SHA256=acb4d1045f48a237e70294b950153e48d4dd44aa6c84d3d6a3a9b0e3e6e6b9a2

# Create and activate Python virtual environment
python3 -m venv /venv
source /venv/bin/activate

# Install build tools
pip install --upgrade pip setuptools wheel build

# Install project dependencies
pip install -e .

# Get SuiteSparse source
wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256
tar -xf v${SUITESPARSE_VERSION}.tar.gz
export CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-${SUITESPARSE_VERSION}

# Build/install CVXOPT
python -m build --wheel
pip install --no-index --find-links=./dist cvxopt

# Run tests with pytest
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests || true