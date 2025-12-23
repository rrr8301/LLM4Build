#!/bin/bash

# Activate Python environment
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv cvxopt_env -p python3.12
workon cvxopt_env

# Install project dependencies
python -m pip install --no-index --find-links=/app/dist cvxopt

# Run tests
set +e  # Continue on errors
python -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests