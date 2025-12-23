#!/bin/bash

# Activate environment (if any virtual environment is used, activate it here)

# Install project dependencies (if any additional Python packages are needed)
# pip install -r requirements.txt

# Configure the build
mkdir -p build
cd build
cmake -DPYTHON3_INCLUDE_PATH=$(python3 -c "from sysconfig import get_paths as gp; print(gp()['include'])") \
      -DPYTHON3_LIBRARIES=$(python3 -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))")/libpython3.12.so \
      -DPYTHON3_NUMPY_INCLUDE_DIRS=$(python3 -c "import numpy; print(numpy.get_include())") \
      -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      ../

# Build the project
make -j$(nproc --all)

# Run tests
ctest --output-on-failure || true  # Ensure all tests run even if some fail