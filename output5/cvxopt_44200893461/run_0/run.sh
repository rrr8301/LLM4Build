#!/bin/bash

# Activate the Python environment
source /usr/bin/activate

# Run the tests
set +e  # Continue executing even if some tests fail
python3.9 -c "from cvxopt import blas,lapack,amd,cholmod,umfpack,glpk,dsdp,gsl,fftw"
pytest --cov=cvxopt tests