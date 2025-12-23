#!/bin/bash

# Activate environment variables
export MSGPACK_CXX_VERSION="MSGPACK_CXX20=ON"
export ARCH=64
export API_VERSION=3
export CHAR_SIGN="signed"
export X3_PARSE="OFF"
export SANITIZE="-fsanitize=undefined -fno-sanitize-recover=all"
export ACTION="ci/build_cmake.sh"

# Set CXX for pattern 2 with specific clang version
export CXX="clang++-14"
export MSGPACK_CXX_VERSION="MSGPACK_CXX14=ON"

# Build and test
CMAKE_CXX_COMPILER="$CXX" CXXFLAGS="-Werror -g ${SANITIZE}" ci/build_cmake.sh || exit 1

# Ensure all test cases are executed
cat Files.cmake | grep ".*\.[h|hpp]" | perl -pe 's/ //g' | sort > tmp1
find include -name "*.h" -o -name "*.hpp" | sort > tmp2
diff tmp1 tmp2