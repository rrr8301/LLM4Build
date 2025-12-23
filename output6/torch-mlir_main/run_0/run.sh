#!/bin/bash

# run.sh

# Activate virtual environment
python3.11 -m venv mlir_venv
source mlir_venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install --pre torch-mlir torchvision \
  --extra-index-url https://download.pytorch.org/whl/nightly/cpu \
  -f https://github.com/llvm/torch-mlir-release/releases/expanded_assets/dev-wheels

# Run build and smoke test
cd /app
TM_PACKAGE_VERSION=${TM_PACKAGE_VERSION:-"0.0.1"}
echo "TORCH_MLIR_PYTHON_PACKAGE_VERSION=${TM_PACKAGE_VERSION}" > ./torch_mlir_package_version
TM_PYTHON_VERSIONS=cp311-cp311 TM_PACKAGES=torch-mlir ./build_tools/python_deploy/build_linux_packages.sh

# Ensure all tests run even if some fail
set +e
# Placeholder for running tests
# e.g., pytest tests/
set -e