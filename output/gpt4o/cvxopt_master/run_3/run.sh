#!/bin/bash

# Set SuiteSparse version and SHA256
export SUITESPARSE_VERSION=5.10.1
export SUITESPARSE_SHA256=acb4d1045f48a237e70294b950153e48d4dd44aa6c84d3d6a3a9b0e3e6e6b9a2

# Create and activate Python virtual environment
python3 -m venv /venv
source /venv/bin/activate

# Install build tools
pip install --upgrade pip setuptools wheel build numpy

# Get SuiteSparse source
wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256
tar -xf v${SUITESPARSE_VERSION}.tar.gz
cd SuiteSparse-${SUITESPARSE_VERSION}
make library
cd ..

# Set environment variables for SuiteSparse
export CVXOPT_SUITESPARSE_SRC_DIR=$(pwd)/SuiteSparse-${SUITESPARSE_VERSION}
export CVXOPT_BUILD_FFTW=1
export CVXOPT_BUILD_GLPK=1
export CVXOPT_BUILD_GSL=1
export CVXOPT_BUILD_DSDP=1

# Install project in development mode
pip install -e .

# Build and install CVXOPT
python setup.py build
python setup.py install

# Run tests with pytest
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests || true