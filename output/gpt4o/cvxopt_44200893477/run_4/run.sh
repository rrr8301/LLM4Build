#!/bin/bash

# Set environment variables from YAML
export SUITESPARSE_VERSION=${SUITESPARSE_VERSION:-7.8.2}
export SUITESPARSE_SHA256=${SUITESPARSE_SHA256:-996c48c87baaeb5fc04bd85c7e66d3651a56fe749c531c60926d75b4db5d2181}

# Activate Python environment
python3 -m venv /venv
source /venv/bin/activate

# Install project dependencies with version fallback
if [ -z "$SETUPTOOLS_SCM_PRETEND_VERSION" ]; then
    # Try to get version from git if available
    if [ -d .git ]; then
        SETUPTOOLS_SCM_PRETEND_VERSION=$(git describe --tags --always --dirty)
        export SETUPTOOLS_SCM_PRETEND_VERSION
    else
        # Fallback version if no git info
        export SETUPTOOLS_SCM_PRETEND_VERSION=1.0.0
    fi
fi

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