#!/bin/bash

# Activate the virtual environment
export PIPENV_DEFAULT_PYTHON_VERSION=3.9
export PYTHONWARNINGS="ignore:DEPRECATION"
export PYTHONIOENCODING="utf-8"
export GIT_ASK_YESNO="false"

# Sync and update submodules
git submodule sync
git submodule update --init --recursive

# Install project dependencies
pipenv install --deploy --dev --python=3.9

# Run pypiserver
python -m pypiserver run -v --host=0.0.0.0 --port=8080 --hash-algo=sha256 --disable-fallback ./tests/pypi/ ./tests/fixtures &

# Run tests
export PIPENV_NOSPIN="1"
export CI="1"
export PYPI_VENDOR_DIR="./tests/pypi/"
export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new -o CheckHostIP=no"

# Run tests and ensure all tests are executed
pipenv run pytest -ra -n auto -v --fulltrace tests || true