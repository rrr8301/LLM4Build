#!/bin/bash

# Create and activate Python virtual environment
python3.12 -m venv /app/venv
source /app/venv/bin/activate

# Install necessary packages in the virtual environment
pip install --upgrade pip
pip install pytest pytest-cov coveralls

# Install cvxopt in the virtual environment
pip install /app/dist/cvxopt-*.whl

# Run tests
set +e  # Continue on error
python3.12 -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests