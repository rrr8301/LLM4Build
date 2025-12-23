#!/bin/bash

# Activate Python environment (if any)
# No virtual environment is specified, using system Python

# Run autogen.sh to generate configure script
./autogen.sh

# Fast configure, build, install, and clean
./configure --disable-dlang --disable-golang --disable-haskell --disable-java \
    --disable-js --disable-ocaml --disable-python --disable-rust --disable-swift \
    --disable-vlang --disable-zig --prefix=$PWD/install
make -j$(nproc)
make -j$(nproc) install
make -j$(nproc) distclean

# Minimal install test
cd install/bin
./re2c --version
cd ../..

# Full configure, build, and install
./configure --prefix=$PWD/full-install --enable-libs --enable-parsers \
    --enable-lexers --enable-docs --enable-debug RE2C_FOR_BUILD=$PWD/install/bin/re2c
find src -name '*.re' | xargs touch
make -j$(nproc)

# Run main test suite
bash -c "ulimit -s 256; make check -j$(nproc)"

# Run skeleton tests
python3 run_tests.py --skeleton

# Full install
make -j$(nproc) install

# Log message for unsupported action
echo "Note: In a real CI environment, test artifacts would be uploaded here."