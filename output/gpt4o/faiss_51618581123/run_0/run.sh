#!/bin/bash

# Activate conda environment
source activate faiss-env

# Build the project using cmake
cmake -B build -DBUILD_TESTING=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .
make -k -C build -j$(nproc)

# Run tests
pytest --junitxml=test-results/pytest/results.xml tests/test_*.py || true
pytest --junitxml=test-results/pytest/results-torch.xml tests/torch_*.py || true