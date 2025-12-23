#!/bin/bash

# Configure checks
echo 'RUN_SUDO="sudo -E"' > tests/t_server_null.rc

# Run tests
set +e  # Continue on error
make -j3 check VERBOSE=1