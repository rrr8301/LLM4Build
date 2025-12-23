#!/bin/bash

# Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate

# Install project dependencies
conda install -y -c conda-forge \
    python=3.11 \
    cmake=3.30.4 \
    make=4.2 \
    swig=4.0 \
    "numpy>=2.0,<3.0" \
    scipy=1.16 \
    pytest=7.4 \
    gflags=2.2 \
    gxx_linux-64=14.2 \
    sysroot_linux-64=2.17 \
    mkl=2024.2.2 \
    mkl-devel=2024.2.2

# Build the project using cmake
cmake -B build -DBUILD_TESTING=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .
make -k -C build -j$(nproc)

# Run tests
pytest --junitxml=test-results/pytest/results.xml tests/test_*.py || true
pytest --junitxml=test-results/pytest/results-torch.xml tests/torch_*.py || true