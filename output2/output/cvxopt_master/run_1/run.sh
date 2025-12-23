#!/bin/bash

# Create and activate Python virtual environment
python3.12 -m venv /app/cvxopt_env
source /app/cvxopt_env/bin/activate

# Install project dependencies
python -m pip install --no-index --find-links=/app/dist cvxopt

# Run tests
set +e  # Continue on errors
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests