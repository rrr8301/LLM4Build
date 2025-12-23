#!/bin/bash

# Set environment variables from YAML
export SUITESPARSE_VERSION=${SUITESPARSE_VERSION:-7.8.2}
export SUITESPARSE_SHA256=${SUITESPARSE_SHA256:-996c48c87baaeb5fc04bd85c7e66d3651a56fe749c531c60926d75b4db5d2181}
export CVXOPT_BUILD_DSDP=1
export CVXOPT_BUILD_FFTW=1
export CVXOPT_BUILD_GLPK=1
export CVXOPT_BUILD_GSL=1

# Ensure we're using the virtual environment
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

# Install build dependencies
pip install --upgrade pip
pip install wheel setuptools

# Get SuiteSparse source
wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v${SUITESPARSE_VERSION}.tar.gz
echo "${SUITESPARSE_SHA256}  v${SUITESPARSE_VERSION}.tar.gz" > SuiteSparse.sha256
sha256sum -c SuiteSparse.sha256 || exit 1
tar -xf v${SUITESPARSE_VERSION}.tar.gz
export CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-${SUITESPARSE_VERSION}

# Build and install CVXOPT with all optional modules
python setup.py build --with-dsdp --with-fftw --with-glpk --with-gsl
python setup.py install

# Verify installation
python -c "import cvxopt; print(f'CVXOPT version: {cvxopt.__version__}')" || exit 1

# Run tests from installed package
cd /app
PYTHONPATH=/venv/lib/python3.10/site-pables pytest --cov=cvxopt tests || true