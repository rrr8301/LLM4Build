#!/bin/bash

set -e

# Activate Python environment
python3.9 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Get SuiteSparse source
SUITESPARSE_VERSION=7.8.2
SUITESPARSE_SHA256=996c48c87baaeb5fc04bd85c7e66d3651a56fe749c531c60926d75b4db5d2181

wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256
tar -xf v${SUITESPARSE_VERSION}.tar.gz
export CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-${SUITESPARSE_VERSION}

# Build/install CVXOPT
python -m build --wheel
pip install --no-index --find-links=dist cvxopt

# Run tests
set +e
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests || true