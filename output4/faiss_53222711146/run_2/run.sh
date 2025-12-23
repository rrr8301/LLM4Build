#!/bin/bash

# Activate conda environment
source /opt/conda/bin/activate faiss-env

# Install project dependencies
conda install -y -q --file requirements.txt

# Build the project
cmake -B build -DBUILD_TESTING=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .
make -k -C build -j$(nproc)

# Run tests
pytest --junitxml=test-results/pytest/results.xml tests/test_*.py || true
pytest --junitxml=test-results/pytest/results-torch.xml tests/torch_*.py || true