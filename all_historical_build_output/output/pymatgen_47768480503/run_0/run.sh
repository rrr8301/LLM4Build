#!/bin/bash

# Activate the mamba environment
source /opt/conda/etc/profile.d/conda.sh
micromamba activate pmg

# Install pymatgen and dependencies
uv build --wheel --no-build-logs
WHEEL_FILE=$(ls dist/pymatgen*.whl)
uv pip install $WHEEL_FILE[prototypes,optional] --resolution=lowest-direct

# Run tests
pytest --splits 10 --group 3 --durations-path tests/files/.pytest-split-durations tests || true