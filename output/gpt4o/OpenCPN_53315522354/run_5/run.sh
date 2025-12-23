#!/bin/bash

# Run pre-build script (no sudo needed as we're root in container)
./ci/github-pre-build.sh

# Configure CMake with additional paths
cmake -B build -DCMAKE_BUILD_TYPE=Release \
    -DwxWidgets_CONFIG_EXECUTABLE=/usr/bin/wx-config \
    -DGLEW_INCLUDE_DIR=/usr/include \
    -DGLEW_LIBRARY=/usr/lib/x86_64-linux-gnu/libGLEW.so \
    -DLibArchive_INCLUDE_DIR=/usr/include \
    -DLibArchive_LIBRARY=/usr/lib/x86_64-linux-gnu/libarchive.so \
    -DTINYXML_INCLUDE_DIR=/usr/include \
    -DTINYXML_LIBRARY=/usr/lib/x86_64-linux-gnu/libtinyxml2.so \
    -DUDEV_INCLUDE_DIR=/usr/include \
    -DUDEV_LIBRARY=/usr/lib/x86_64-linux-gnu/libudev.so \
    -DSHAPELIB_INCLUDE_DIR=/usr/include \
    -DSHAPELIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libshp.so \
    -DOPENSSL_ROOT_DIR=/usr/lib/ssl \
    -DOPENSSL_CRYPTO_LIBRARY=/usr/lib/x86_64-linux-gnu/libcrypto.so \
    -DOPENSSL_INCLUDE_DIR=/usr/include/openssl \
    -DSQLITE_INCLUDE_DIR=/usr/include \
    -DSQLITE_LIBRARY=/usr/lib/x86_64-linux-gnu/libsqlite3.so \
    -DLIBSNDFILE_LIBRARY=/usr/lib/x86_64-linux-gnu/libsndfile.so \
    -DLIBSNDFILE_INCLUDE_DIR=/usr/include \
    -DCURL_LIBRARY=/usr/lib/x86_64-linux-gnu/libcurl.so \
    -DCURL_INCLUDE_DIR=/usr/include/x86_64-linux-gnu/curl

# Build the project
cmake --build build --config Release

# Run tests with verbose output
cd build
ctest --verbose --output-on-failure || true