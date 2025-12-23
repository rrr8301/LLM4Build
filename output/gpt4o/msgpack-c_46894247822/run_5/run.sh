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
export CC="clang-14"
export MSGPACK_CXX_VERSION="MSGPACK_CXX14=ON"

# Ensure make is available
export CMAKE_MAKE_PROGRAM=/usr/bin/make

# Set Boost and Zlib paths
export BOOST_ROOT=/usr/include/boost
export ZLIB_ROOT=/usr/include/zlib

# Build and test
CMAKE_CXX_COMPILER="$CXX" CMAKE_MAKE_PROGRAM="$CMAKE_MAKE_PROGRAM" \
CXXFLAGS="-Werror -g ${SANITIZE}" LDFLAGS="-L/usr/lib/llvm-14/lib/clang/14.0.6/lib/linux/" ./ci/build_cmake.sh || exit 1

# Ensure all test cases are executed
cat Files.cmake | grep ".*\.[h|hpp]" | perl -pe 's/ //g' | sort > tmp1 && \
find include -name "*.h" -o -name "*.hpp" | sort > tmp2 && \
diff tmp1 tmp2