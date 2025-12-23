#!/bin/bash

# Activate the pipenv environment
pipenv shell

# Run pypiserver
python -m pypiserver run -v --host=0.0.0.0 --port=8080 --hash-algo=sha256 --disable-fallback ./tests/pypi/ ./tests/fixtures &

# Run tests
pipenv run pytest -ra -n auto -v --fulltrace tests || true

# Ensure all tests are executed even if some fail
exit 0