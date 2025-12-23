#!/bin/bash

# Activate environments if needed (none in this case)

# Install project dependencies
# Java dependencies are handled by Maven
# C++ dependencies are already installed via apt-get

# Build and Test C++
cd cpp
mkdir build
cd build
cmake ..
make
./tools/generate_geocoding_data_test || true
./libphonenumber_test || true
cd ../..

# Build and Test Java
mvn install -P github-actions -DskipTests=true -Dmaven.javadoc.skip=true -B -V
mvn -P github-actions test || true
ant clean -f java/build.xml
ant jar -f java/build.xml
ant junit -f java/build.xml || true

# Check JS ASCII Safety
find . -name '*.js' ! -name '*_test.js' | xargs is-ascii-safe || true