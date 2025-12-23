# run.sh
#!/bin/bash

# Activate environment (if needed, PyPy doesn't use virtualenv by default)
# Install project dependencies
pypy3 -m pip install --upgrade pip
pypy3 -m pip install tox

# Run tests
# Ensure all tests are executed, even if some fail
tox -e tests || true