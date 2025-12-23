#!/bin/bash

# Create and activate Python virtual environment
python3.12 -m venv /app/cvxopt_env
source /app/cvxopt_env/bin/activate

# Install project dependencies
# Install cvxopt from PyPI or another valid source
python -m pip install cvxopt

# Run tests
set +e  # Continue on errors
source /app/cvxopt_env/bin/activate  # Ensure the virtual environment is activated
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests