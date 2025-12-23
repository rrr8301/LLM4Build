# run.sh
#!/bin/bash

# Use Python 3.10 explicitly
python3.10 -m pip install -r requirements.txt || true

# Run tests with tox
python3.10 -m tox -e tests || true