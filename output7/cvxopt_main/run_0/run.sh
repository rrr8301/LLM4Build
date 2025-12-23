#!/bin/bash

# Activate Python environment
source /usr/local/bin/virtualenvwrapper.sh
workon cvxopt

# Run tests
set +e  # Continue on error
python3.12 -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests