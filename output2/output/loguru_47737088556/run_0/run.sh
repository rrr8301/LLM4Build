# run.sh
#!/bin/bash

# Activate Python 3.10
alias python=python3.10
alias pip=pip3

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with tox
tox -e tests || true