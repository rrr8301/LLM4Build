#!/bin/bash

# Activate environment variables if any (none in this case)

# Generate project files
cmake -S . -B . -D MZ_CODE_COVERAGE=ON -D MZ_BUILD_TESTS=ON -D MZ_BUILD_UNIT_TESTS=ON -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release -D CMAKE_C_COMPILER=clang-14 -D CMAKE_CXX_COMPILER=clang++-14

# Compile source code
cmake --build . --config Release

# Run test cases
ctest --output-on-failure -C Release || true

# Generate coverage report
python3 -m gcovr \
  --exclude-unreachable-branches \
  --gcov-ignore-parse-errors \
  --gcov-executable "llvm-cov-14 gcov" \
  --root . \
  --xml \
  --output coverage.xml \
  --verbose

# Note: Uploading coverage report to Codecov is not supported in this script.
# Please manually upload 'coverage.xml' to Codecov using their CLI or web interface.