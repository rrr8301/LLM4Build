#!/bin/bash

# Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate

# Install project dependencies
conda install -y -c conda-forge "conda!=24.11.0" "conda-build=25.3.1" "liblief=0.14.1"

# Run conda build for CPU
conda build faiss --python 3.11 -c pytorch || true

# Check installed packages channel
conda list --show-channel-urls || true

# Ensure all test cases are executed
set +e
# Add any additional test commands here
set -e